//Store
var {Sequelize, sequelize} = require('../../config/sequelize.js');
const { Op } = require("sequelize");
//const { Game, GamePlaying, Hero, QuantityLookup, HeroTierTicket, UserMeta, Option } = require('./');
const Game = require('./Game');
const GamePlaying = require('./GamePlaying');
const Hero = require('./Hero');
const QuantityLookup = require('./QuantityLookup');
const HeroTierTicket = require('./HeroTierTicket');
const UserMeta = require('./UserMeta');
const Option = require('./Option');

const { Token } = require('../cq-models');
const fn = require('../Functions');
const _ = require('lodash');
var moment = require('moment');
const { Solana } = require('../solana');

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

// Check and sync heroes (tokens)
User.prototype.checkAndSyncHeroes = async function(){
	const Sol = new Solana();
	const tokens = await Sol.getTokensByOwner(this.wallet_address);
	tokens.forEach( async token => {
		const findToken = await Hero.findOne({where: {user_id: parseInt(this.id), mint: token}});
		if(findToken === null){
			await Hero.create({
				mint: token,
				user_id: parseInt(this.id),
				active: 0,
				extra_data: {}
			});
		}
	})
}

// Get wallet address by id
User.getWalletAddressById = async function(user_id){
	const user = await User.findByPk(user_id);
	if(!user)
		return '';
	return user.wallet_address;
}

// Get current game
User.prototype.getCurrentGame = async function(game_id){
	const {start_date, end_date} = fn.dateRange();
	let where = {};
	if(typeof game_id !== 'undefined'){
		game_id = parseInt(game_id);
		where = {
			game_id: game_id
		}
	}else{
		game_id = 0;
		where = {
			user_id: parseInt(this.id),
	      	created_at: { 
	        	[Op.gt]: start_date,
	        	[Op.lt]: end_date
	      	},
	      	finished: 0
	    }
	}

    return await GamePlaying.findOne({where: where, order: [['id', 'DESC']]});
}

/**
 * [description]
 * @return {[type]} [description]
 */
User.prototype.getCurrentGameId = async function(){
	const game = await this.getCurrentGame();
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
	let user_nne = await this.getNonNftEntries();
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

	if(non_nft_entries > 0){
		price_per_entry = await getPricePerEntry(non_nft_entries);
		const hero_tier_nne = await HeroTierTicket.findOne({where: {tier: 'Non-NFT'}});
		ticket_total += non_nft_entries * parseInt(hero_tier_nne.tickets);
		entry_total += non_nft_entries;
		TotalSpent += price_per_entry*non_nft_entries;
	}

	if(tokens && tokens.length > 0){
		let tokens_data = [];
		await Promise.all(tokens.map(async (token) => {
			let token_tmp = token;
			const token_info = await token.getExtraInfo();
			let entry_legacy = token_info.legacy;
			//entry_total += parseInt(entry_legacy);
			entry_total++;
			token_tmp.token_info = token_info;
			tokens_data.push(token_tmp);
		}));

		//entry_total += non_nft_entries; // addition Non-NFT amount
		price_per_entry = await getPricePerEntry(entry_total);

		// Get hero tier ticket data
		// Total Tickets per Entry = Base Tickets + Extra Tickets from Hero Stats
		const hero_tier_data = await HeroTierTicket.findAll();
		tokens_data.forEach( async token => {
			var var_of_hero_tier = _.chain(hero_tier_data).filter(function (h) { return h.tier === token.hero_tier }).first().value();
			const token_info = token.token_info;
			const legacy = token_info.legacy;
			let spent_per_hero = price_per_entry;
			let ticket_per_hero = var_of_hero_tier.tickets; // Base Tickets
			const extraTickets = var_of_hero_tier.tix_from_stats;
			TotalSpent += spent_per_hero;
			ticket_total += ticket_per_hero;
			ticket_total += extraTickets;
		});
	}

	//let game_calc = await Option._get('last_update_entry_calc');
	let game_calc = await Game.getData();
	if(game_calc === '' || game_calc === null){
		game_calc = {
			NoRakePrizePool: 0,
            PostRakePrizePool: 0,
            entry_total: 0,
            price_per_entry: 0,
            non_entry_total: 0,
            ticket_total: 0,
            user_total: 0,
            EstUsers: 0,
            EstRakePerDay: 0,
            tokens: []
		}
	}
	
	// Set data to property of object
	const ChanceOfWinning = game_calc.ticket_total === 0? 0: ticket_total/game_calc.ticket_total;
	const ChanceNotWin = 1 - ChanceOfWinning;
	const NoRakeEV = (ChanceOfWinning*game_calc.NoRakePrizePool)+(-ChanceNotWin*TotalSpent);
	const PostRakeEV = (ChanceOfWinning*game_calc.PostRakePrizePool)+(-ChanceNotWin*TotalSpent);

	// Get current game
	const currentGame = await this.getCurrentGame();

	entry_cal.TotalSpent = TotalSpent;
	entry_cal.entry_total = entry_total;
	entry_cal.price_per_entry = price_per_entry;
	entry_cal.non_entry_total = non_nft_entries;
	entry_cal.ticket_total = ticket_total;
	entry_cal.ChanceOfWinning = ChanceOfWinning;
	entry_cal.ChanceNotWin = ChanceNotWin;
	entry_cal.NoRakeEV = NoRakeEV;
	entry_cal.PostRakeEV = PostRakeEV;
	entry_cal.tokens = _.isEmpty(currentGame.heroes)? []: JSON.parse(currentGame.heroes);
	//console.log(entry_cal);
	//UserMeta._update(user_id, 'current_entries_calc', JSON.stringify(entry_cal));
	
	if(currentGame !== null){
		currentGame.update({data: entry_cal});
		currentGame.save();
	}
	
	return entry_cal;
}

/**
 * [description]
 * @return {[type]} [description]
 */
User.prototype.getNonNftEntries = async function() {
	const game = await this.getCurrentGame();
    return game !== null? parseInt(game.non_nft_entries): 0;
}

/**
 * [description]
 * @return {[type]} [description]
 */
User.prototype.getCurrentEntriesCalc = async function() {
	const currentGame = await this.getCurrentGame();
	let current_entries_calc = currentGame !== null? currentGame.data: {};
	if(_.isEmpty(current_entries_calc)){
		current_entries_calc = JSON.parse('{"TotalSpent":0, "entry_total":0, "non_entry_total":0, "ticket_total":0, "ChanceOfWinning":0, "ChanceNotWin":0, "NoRakeEV":0, "PostRakeEV":0}');
	}
	return current_entries_calc;
}

/**
 * [description]
 * @return {[type]} [description]
 */
User.prototype.getSubmitted = async function(){
	const currentGame = await this.getCurrentGame();
	let submitted = currentGame !== null? currentGame.submitted: [];
	if(_.isEmpty(submitted)){
		submitted = [];
	}
	return submitted;
}

/**
 * [description]
 * @return {[type]} [description]
 */
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
				active: hero.active,
				extra_data: hero.extra_data
			});
		})
	}

	const heroes_info = await Hero.getTokenInfoByArr(heroes_mint);
	heroes_arr.forEach( hero => {
		hero.stats = hero.extra_data;
		hero.info = _.chain(heroes_info).filter(function (hi) { return hi.token_address === hero.mint }).first().value();
	})

	return {heroes_mint: heroes_mint, heroes_data: heroes_arr};
}

/**
 * [description]
 * @return {[type]} [description]
 */
User.prototype.updateBalance = async function(amount){
	let balance = parseFloat(this.balance) || 0;
	balance += parseFloat(amount);
	this.update({balance: balance});
	this.save();
}

module.exports = User;