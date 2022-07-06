/**
 * User Controller
 */
const { Hero, UserMeta, GamePlaying } = require('../models');
const { Op } = require("sequelize");
const User = require('../models/User');
const Game = require('../models/Game');
var moment = require('moment');
const GameHelper = require('../GameHelper');

/**
 * [description]
 * @param  {[type]} req [description]
 * @param  {[type]} res [description]
 * @return {[type]}     [description]
 */
exports.updateHeroStatus = async (req, res) => {
	// console.log(req)
	let update = false;
	const hero_mint = req.body.hero_mint;
	const user_id = parseInt(req.user.id);

	const hero = await Hero.findOne({ where: {mint: hero_mint, user_id: user_id} })
	if(hero){
		let status = hero.active;
		if(status === null || status === ''){
			status = 1;
		}else{
			status = !status;
		}

		hero.active = !status? 0: 1;
		update = await hero.save();
	}

	// Update current game
	const helper = new GameHelper();
	helper.PrepareCalculation();

	const user = await User.findByPk(user_id);
	const game_info = await user.getCalGameInfo();
	UserMeta._update(user_id, 'current_entries_calc', JSON.stringify(game_info));

	res.json({ 
		success: true,
		update: update,
		game_info: game_info
	});
}

/**
 * Update Non-NFT Entries:
 * @param  {[type]} req [description]
 * @param  {[type]} res [description]
 * @return {[type]}     [description]
 */
exports.updateNonNftEntries = async (req, res) => {
	const user_id = parseInt(req.user.id);
	const entries = req.body.entries || 0;
	await UserMeta._update(user_id, 'non_nft_entries', entries);

	// Update current game
	const helper = new GameHelper();
	helper.PrepareCalculation();

	const user = await User.findByPk(user_id);
	const game_info = await user.getCalGameInfo();
	
	res.json({ 
		success: true,
		game_info: game_info
	});
}

/**
 * Enter the game, will create new game for today
 * @param  {[type]} req [description]
 * @param  {[type]} res [description]
 * @return {[type]}     [description]
 */
exports.enterGame = async (req, res) => {
	const user_id = parseInt(req.user.id);
	const user = await User.findByPk(user_id);

	let game_id = await Game.getCurrentId();
	// Check game today is created
	if(!game_id){
		const game = await Game.create({data: {}, end: 0});
		game_id = parseInt(game.id);
	}

	let game_playing_id = await user.getCurrentGameId();
	const game_info = await user.getCalGameInfo();
	let json_data = game_info;

	if(!game_playing_id){
		let game_playing = await GamePlaying.create({
			user_id: user_id,
			game_id: game_id,
			data: json_data,
			won: 0,
			bonus: 0,
			note: '',
			heroes: [],
			finished: 0,
			winning_hero: ''
		});
		game_playing_id = parseInt(game_playing.id);
	}else{
		//console.log(game);
	}

	const helper = new GameHelper();
	helper.PrepareCalculation();
	
	res.json({ 
		success: true,
		game_info: game_info,
		game_playing_id: game_playing_id
	});
}