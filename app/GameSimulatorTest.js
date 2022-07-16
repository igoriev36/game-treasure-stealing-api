/**
 * Game simulator class for test
 */
const { GamePlaying, Hero, UserMeta } = require('./models');
const User = require('./models/User');
const Game = require('./models/Game');
const { Op } = require("sequelize");
var moment = require('moment');
var uniqid = require('locutus/php/misc/uniqid');
const fn = require('./Functions');

class GameSimulatorTest{
	constructor() {
		// constructor
		this.format_date = 'YYYY-MM-DD 17:00:00';
	}

	ranSTR(length) {
	    var result           = '';
	    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
	    var charactersLength = characters.length;
	    for ( var i = 0; i < length; i++ ) {
	      result += characters.charAt(Math.floor(Math.random() * charactersLength));
	   	}
	   	return result;
	}

	async createUsers(total){
		let self = this;

		if(typeof total === 'undefined'){
			total = 20;
		}

		for(var u=0; u<total;u++){
			const email = 'u' + Math.floor(Math.random() * (100000 - 10000 + 1) + 10000) + '@cqgame.com';
			await User.create({
				fullname          	: `Test 0${u}`,
				wallet_address      : self.ranSTR(44),
				email           	: email,
				email_verified_at 	: null,
				password   			: '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6',
				active      	    : 1,
				sol_balance       	: 0,
				total_loot        	: 0,
				total_loot_won      : 0,
				loose_loost        	: 0,
			  	avatar_url   		: '',
			  	uid   			    : uniqid(6)
			});
		}
	}

	async createGameForAllUser(){
		const self = this;
		console.log('Start')
		const users = await User.findAll();
		if(users){
			let game_id = await Game.getCurrentId();

			if(!game_id){
				const game = await Game.create({data: {}, end: 0});
				game_id = game !== null? parseInt(game.id): 0;
			}

			users.forEach( async user => {
				const user_id = parseInt(user.id);
				const game_info = await user.getCalGameInfo();

				const {start_date, end_date} = fn.dateRange();
				const game = await GamePlaying.findOne({where: {
					user_id: user_id,
					game_id: game_id,
			      	created_at: { 
			        	[Op.gt]: start_date,
			        	[Op.lt]: end_date
			      	},
			      	finished: 0
			    }});

				let json_data = game_info;
			    if(!game){
					await GamePlaying.create({
						user_id: user_id,
						game_id: game_id,
						data: json_data,
						won: 0,
						bonus: 0,
						note: '',
						finished: 0
					});
				}

				const non_nft_entries = Math.floor(Math.random() * 100 + 1);
				UserMeta._update(user_id, 'non_nft_entries', non_nft_entries);
			});

			await Hero.update({active:1},{where: {active: 0}});
		}
	}
}

module.exports = GameSimulatorTest;