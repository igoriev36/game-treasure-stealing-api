//Store
var {Sequelize, sequelize} = require('../../config/sequelize.js');
const { Op } = require("sequelize");
const { Game, GamePlaying, Hero, QuantityLookup, HeroTierTicket, UserMeta, Option } = require('./');
const { Token } = require('../cq-models');
const fn = require('../Functions');
const _ = require('lodash');
var moment = require('moment');

var User = sequelize.define('User', {
	id: {
		type: Sequelize.BIGINT,
		allowNull: false,
		autoIncrement: true,
		primaryKey: true
	},
	fullname          	: Sequelize.STRING,
	wallet_address      : Sequelize.STRING,
	email           	: Sequelize.STRING,
	email_verified_at 	: Sequelize.DATE,
	password   			: Sequelize.STRING,
	active      	    : Sequelize.INTEGER,
	balance       		: Sequelize.FLOAT,
	total_loot        	: Sequelize.FLOAT,
	total_loot_won      : Sequelize.FLOAT,
	loose_loost        	: Sequelize.FLOAT,
  	avatar_url   		: Sequelize.STRING,
  	uid   			    : Sequelize.STRING
},{
	tableName    	: 'users',
	createdAt    	: 'created_at',
	updatedAt    	: 'updated_at',
	timestamps   	: true,
	underscored  	: true
});

User.prototype.getCurrentGameId = async function(){
	const {start_date, end_date} = fn.dateRange();
	const game = await GamePlaying.findOne({where: {
		user_id: parseInt(this.id),
      	created_at: { 
        	[Op.gt]: start_date,
        	[Op.lt]: end_date
      	},
      	finished: 0
    }});

    return game !== null? parseInt(game.id): 0;
}

// Calc game info each user
User.prototype.getCalGameInfo = async function() {
	const user_id = parseInt(this.id);
	const heroes = await Hero.findAll({where: {user_id: user_id, active: 1}});
	let user_token_address = [];
	if(heroes){
		user_token_address = _.map(heroes, 'mint');
	}

	const tokens = await Token.findAll({where: {token_address: user_token_address}});

	// get Non-NFT
	let non_nft_entries = 0;
	let user_nne = await UserMeta._get(user_id, 'non_nft_entries', true);
	if(user_nne){
		non_nft_entries = parseInt(user_nne);
	}

	let entry_cal = {};
	let entry_total = 0;
	let ticket_total = 0;
	let TotalSpent = 0;
	let price_per_entry = 0;

	const getPricePerEntry = async (entry_total) => {
		const look = await QuantityLookup.findOne({where:{quantity_from: {[Op.lte]: entry_total}}, order: [['quantity_from', 'DESC']]});
		return look !== null? look.value: 0;
	}

	if(tokens && tokens.length > 0){
		let tokens_data = [];
		await Promise.all(tokens.map(async (token) => {
			let token_tmp = token;
			const token_info = await token.getExtraInfo();
			let entry_legacy = token_info.legacy;
			entry_total += parseInt(entry_legacy);
			token_tmp.token_info = token_info;
			tokens_data.push(token_tmp);
		}));

		entry_total += non_nft_entries; // addition Non-NFT amount
		price_per_entry = await getPricePerEntry(entry_total);

		// Get hero tier ticket data
		const hero_tier_data = await HeroTierTicket.findAll();
		tokens_data.forEach( token => {
			var var_of_hero_tier = _.chain(hero_tier_data).filter(function (h) { return h.tier === token.hero_tier }).first().value();
			const token_info = token.token_info;
			const legacy = token_info.legacy;
			let spent_per_hero = price_per_entry*legacy;
			let ticket_per_hero = legacy*var_of_hero_tier.tickets;
			TotalSpent += spent_per_hero;
			ticket_total += ticket_per_hero;
		});
	}

	if(non_nft_entries > 0){
		price_per_entry = await getPricePerEntry(non_nft_entries);
		const hero_tier_nne = await HeroTierTicket.findOne({where: {tier: 'Non-NFT'}});
		ticket_total += non_nft_entries * parseInt(hero_tier_nne.tickets);
		entry_total += non_nft_entries;
		TotalSpent += price_per_entry*non_nft_entries;
	}

	//let game_calc = await Option._get('last_update_entry_calc');
	let game_calc = await Game.getData();
	if(game_calc === '' || game_calc === null){
		game_calc = {
			NoRakePrizePool: 0,
            PostRakePrizePool: 0,
            entry_total: 0,
            ticket_total: 0,
            user_total: 0,
            EstUsers: 0,
            EstRakePerDay: 0
		}
	}
	
	// Set data to property of object
	const ChanceOfWinning = game_calc.ticket_total === 0? 0: ticket_total/game_calc.ticket_total;
	const ChanceNotWin = 1 - ChanceOfWinning;
	const NoRakeEV = (ChanceOfWinning*game_calc.NoRakePrizePool)+(-ChanceNotWin*TotalSpent);
	const PostRakeEV = (ChanceOfWinning*game_calc.PostRakePrizePool)+(-ChanceNotWin*TotalSpent);

	entry_cal.TotalSpent = TotalSpent;
	entry_cal.entry_total = entry_total;
	entry_cal.ticket_total = ticket_total;
	entry_cal.ChanceOfWinning = ChanceOfWinning;
	entry_cal.ChanceNotWin = ChanceNotWin;
	entry_cal.NoRakeEV = NoRakeEV;
	entry_cal.PostRakeEV = PostRakeEV;
	//console.log(entry_cal);
	UserMeta._update(user_id, 'current_entries_calc', JSON.stringify(entry_cal));

	return entry_cal;
}

User.prototype.getNonNftEntries = async function() {
	const non_nft_entries = await UserMeta._get(parseInt(this.id), 'non_nft_entries', true);
	return parseInt(non_nft_entries);
}

User.prototype.getCurrentEntriesCalc = async function() {
	let current_entries_calc = await UserMeta._get(parseInt(this.id), 'current_entries_calc', true);
	if(current_entries_calc){
		current_entries_calc = JSON.parse(current_entries_calc);
	}else{
		current_entries_calc = JSON.parse('{"TotalSpent":0,"entry_total":0,"ticket_total":0,"ChanceOfWinning":0,"ChanceNotWin":0,"NoRakeEV":0,"PostRakeEV":0}');
	}
	return current_entries_calc;
}

User.prototype.getHeroes = async function(){
	let heroes_mint = [];
	let heroes = await Hero.findAll({ where: { user_id: parseInt(this.id) }});
	let heroes_arr = [];
	if(heroes !== null && heroes.length > 0){
		heroes.forEach( hero => {
			heroes_mint.push(hero.mint);
			heroes_arr.push({
				id: parseInt(hero.id),
				mint: hero.mint,
				active: hero.active
			});
		})
	}

	const heroes_info = await Hero.getTokenInfoByArr(heroes_mint);
	heroes_arr.forEach( hero => {
		hero.info = _.chain(heroes_info).filter(function (hi) { return hi.token_address === hero.mint }).first().value();
	})

	return {heroes_mint: heroes_mint, heroes_data: heroes_arr};
}

User.prototype.updateBalance = async function(amount){
	let balance = parseFloat(this.balance) || 0;
	balance += parseFloat(amount);
	this.update({balance: balance});
	this.save();
}

module.exports = User;