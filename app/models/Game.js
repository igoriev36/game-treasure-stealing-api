//Store
var {Sequelize, sequelize} = require('../../config/sequelize.js');
const Op = Sequelize.Op;
var GamePlaying = require('../models/GamePlaying');
const fn = require('../Functions');
const _ = require('lodash');
var moment = require('moment');

var Game = sequelize.define('Game', {
	id: {
		type: Sequelize.BIGINT,
		allowNull: false,
		autoIncrement: true,
		primaryKey: true
	},
	data          	: Sequelize.JSON,
	result          : Sequelize.STRING,
	back_pot		: Sequelize.FLOAT,
	thieves_count	: Sequelize.INTEGER,
	end				: Sequelize.INTEGER,
	note			: Sequelize.TEXT,
	raked			: Sequelize.FLOAT
},{
	tableName    	: 'games',
	createdAt    	: 'created_at',
	updatedAt    	: 'updated_at',
	timestamps   	: true,
	underscored  	: true
});

Game.getTodayGame = async function(){
	const {start_date, end_date} = fn.dateRange();
	const game = await Game.findOne({where: {
      	created_at: { 
        	[Op.gt]: start_date,
        	[Op.lt]: end_date
      	},
      	end: 0
    }});
    return game;
}

// Get current game today
Game.getCurrentId = async function(){
	const game = await Game.getTodayGame();
    return game !== null? parseInt(game.id): 0;
}

Game.getQueuedThieves = async function(game_id){
	if(typeof game_id !== 'undefined'){
		game_id = parseInt(game_id);
	}else{
		game_id = await Game.getCurrentId();
	}

	const count = await GamePlaying.count({where: {game_id: game_id}});
	await Game.update({thieves_count: count}, {where: {id: game_id}});
	return count;
}

Game.getPot = async function(game_id){
	if(typeof game_id !== 'undefined' && game_id !== 0){
		game_id = parseInt(game_id);
	}else{
		game_id = await Game.getCurrentId();
	}

	const playing_list = await GamePlaying.findAll({where: {game_id: game_id}});
	let total = 0;
	let main_pot = 0;
	let bonus = 0;
	if(playing_list){
		playing_list.forEach( playing => {
			let submitted = !_.isEmpty(playing.submitted)? playing.submitted: [];
			const data = _.last(submitted);
			total += parseFloat(data.TotalSpent);
		})
	}

	main_pot = total*66/100;
	bonus = total*33/100;

	return {main_pot: main_pot, bonus: bonus};
}

Game.getData = async function(game_id){
	let game = null;
	if(typeof game_id !== 'undefined' && game_id !== 0){
		game  = await Game.findByPk(parseInt(game_id));
	}else{
		game = await Game.getTodayGame();
	}
	
	return game !== null? game.data: {};
}

// Update game data
Game.updateData = async function(data_json, game_id){
	if(typeof game_id === 'undefined' || game_id === 0){
		game_id = await Game.getCurrentId();
	}
	return await Game.update(data_json, {where: {id: game_id}});
}

Game.updateBackPot = async function(back_pot, game_id){
	return await Game.updateData({back_pot, back_pot}, game_id);
}

// Set current game to ended
Game.setEndGame = async function(game_id){
	if(typeof game_id === 'undefined')
		return false;
	game_id = parseInt(game_id);
	await GamePlaying.update({finished: 1}, {where: {game_id: game_id}});
	return await Game.updateData({end: 1}, game_id);
}

// Get back_pot yesterday
Game.getBackPot = async function(){
	const {start_data, end_date} = fn.lastDateRange();
	const game = await Game.findOne({where: {
      	created_at: { 
        	[Op.gt]: start_data,
        	[Op.lt]: end_date
      	},
      	end: 0
    }});
    return game !== null? parseFloat(game.back_pot): 0;
}

module.exports = Game;