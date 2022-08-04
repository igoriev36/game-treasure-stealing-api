/**
 * User Controller
 */
const { Hero, UserMeta, GamePlaying, Transaction } = require('../models');
const { Op } = require("sequelize");
const User = require('../models/User');
const Game = require('../models/Game');
var moment = require('moment');
const GameHelper = require('../GameHelper');
const stripslashes = require('locutus/php/strings/stripslashes');
const { Solana } = require('../solana');

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
	const user = await User.findByPk(user_id);
	const hero = await Hero.findOne({ where: {mint: hero_mint, user_id: user_id} });
	let currentGame = await user.getCurrentGame();

	if(currentGame === null){
		currentGame = await GamePlaying.create({user_id: user_id, data: {}, heroes: '[]', finished: 0, non_nft_entries: 0}).then( data => {
			return data;
		}).catch( error => {
			console.log(error);
		});
	}

	let heroes_arr = currentGame !== null && typeof currentGame.heroes === 'string'? currentGame.heroes: '[]';
	heroes_arr = JSON.parse(heroes_arr);

	if(hero && currentGame !== null){
		let status = hero.active;
		if(status === null || status === ''){
			status = 1;
		}else{
			status = !status;
		}

		hero.active = !status? 0: 1;
		update = await hero.save();

		// Check and add to list
		if(heroes_arr.indexOf(hero.mint) === -1 && status){
			heroes_arr.push(hero.mint);
		}else{
			heroes_arr = heroes_arr.filter(function(token){ return token != hero.mint; });
		}

		currentGame.heroes = stripslashes(JSON.stringify(heroes_arr));
		await currentGame.save();
	}

	// Update current game
	const helper = new GameHelper();
	helper.PrepareCalculation();

	const game_info = await user.getCalGameInfo();
	//UserMeta._update(user_id, 'current_entries_calc', JSON.stringify(game_info));

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

	const user = await User.findByPk(user_id);
	let currentGame = await user.getCurrentGame();

	if(currentGame === null){
		currentGame = await GamePlaying.create({user_id: user_id, data: {}, heroes: '[]', finished: 0, non_nft_entries: 0});
	}

	await currentGame.updateNonNftEntries(entries);
	const game_info = await user.getCalGameInfo();
	//await UserMeta._update(user_id, 'non_nft_entries', entries);

	// Update current game
	const helper = new GameHelper();
	helper.PrepareCalculation();

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
	const signature = req.body.signature;
	const timestamp = req.body.timestamp;
	const user_id = parseInt(req.user.id);
	const user = await User.findByPk(user_id);
	const Sol = new Solana(); 

	let game_id = await Game.getCurrentId();
	// Check game today is created
	if(!game_id){
		const game = await Game.create({data: {}, end: 0});
		game_id = parseInt(game.id);
	}

	if(signature === undefined || signature === '' || !await Sol.isValidTransaction(signature, user.wallet_address)){
		res.json({ 
			success: false,
			game_info: {},
			game_id: 0,
			game_playing_id: 0,
			message: 'Invalid transaction signature'
		});
		exit;
	}else{
		await Transaction.create({
			type: 'game_payout',
            amount: 0,
            event: `game_payout`,
            user_id: user_id,
            description: '',
            signature: signature,
            game_id: game_id
		});
	}

	let currentGame = await user.getCurrentGame();
	let game_playing_id = 0;

	const game_info = await user.getCalGameInfo();
	let json_data = game_info;

	if(currentGame === null){
		currentGame = await GamePlaying.create({
			user_id: user_id,
			game_id: game_id,
			data: json_data,
			won: 0,
			bonus: 0,
			note: '',
			heroes: '[]',
			finished: 0,
			winning_hero: '',
			non_nft_entries: 0
		});
		
	}else{
		currentGame.game_id = game_id;
		currentGame.save();
	}

	game_playing_id = parseInt(currentGame.id);

	const helper = new GameHelper();
	helper.PrepareCalculation();
	
	res.json({ 
		success: true,
		game_info: game_info,
		game_id: game_id,
		game_playing_id: game_playing_id
	});
}

exports.getBalanceWallet = async (req, res) => {
	const wallet_address = req.body.wallet_address;
	const wallet = req.user.wallet;
	const Sol = new Solana();
	const balance = await Sol.getSolBalance(wallet);
	res.json({ 
		success: true,
		balance: parseFloat(balance)
	});
}