const User = require('../models/User');
const { Hero, UserMeta, RefreshToken } = require('../models');

//var qs = require('qs');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
var gravatar = require('gravatar');
const Tools = require('../Tools');
const { v4: uuidv4 } = require('uuid');
var moment = require('moment'); // require
var randomstring = require("randomstring");
var uniqid = require('locutus/php/misc/uniqid');

/**
 * Connect wallet method
 * @param  {Object} req [description]
 * @param  {Object} res [description]
 * @return {[type]}     [description]
 */
exports.connectWallet = async (req, res) => {
	let success = true;
	let message = '';
	const wallet = req.body.wallet;
	const signature = req.body.signature;
	let token = null;
	let refresh_token = null;

	let user = await User.findOne({where: {wallet_address: wallet}}).then( res => {
		return res !== null? res.dataValues: null
	}).catch( () => {
		return null
	})
		
	if(!user){
		const password = randomstring.generate();
		const hash = await bcrypt.hash(password, 10);

		const user = await User.create({
			fullname: '',
			wallet_address: wallet,
			password: hash,
			email: null,
			email_verified_at: null,
			balance: 0,
			active: 1,
			sol_balance: 0,
			total_loot: 0,
			total_loot_won: 0,
			loose_loost: 0,
		  	avatar_url: '',
			uid: uniqid(6)
		});

		user.fullname = `b${user.id}`;
		user.save();
	}

	if(user){
		delete user.password

		let token_id = uuidv4();
		user.token_id = token_id;

		token = jwt.sign(user, process.env.TOKEN_SECRET, { expiresIn: process.env.TOKEN_EXPIRES_IN });
		refresh_token = jwt.sign(user, process.env.REFRESH_TOKEN_SECRET, { expiresIn: process.env.REFRESH_TOKEN_EXPIRES_IN });

		let payload = jwt.decode(refresh_token);
		let expires_at = moment(payload.exp*1000).format("YYYY-MM-DD hh:mm:ss");

		const token_data = await RefreshToken.create({ id: token_id, token: refresh_token, data: JSON.stringify(user), expires_at: expires_at }).then( data => {
			return data !== null? data.dataValues: null
		}).catch( error => {
			console.log(error);
		});

		message = 'Login successfully'
	}

	res.json({
		success: success,
		message: message,
		data: {
			token: token,
			refresh_token: refresh_token
		}
	});
}

/**
 * Login method
 * @param  {Object} req [description]
 * @param  {Object} res [description]
 * @return {[type]}     [description]
 */
exports.login = async (req, res) => {
	let email = req.body.email
	let password = req.body.password
	let success = true
	let token = null
	let refresh_token = null
	let message = ''

	let user = await User.findOne({where: {email: email}}).then( res => {
		return res !== null? res.dataValues: null
	}).catch( () => {
		return null
	})
	//console.log(user)

	if(user !== null){
		user.checkAndSyncHeroes(); // Check and sync heros

		let hash = user.password;
		hash = hash.replace(/^\$2y(.+)$/i, '$2a$1');

		let match = await bcrypt.compare(password, hash)

		if(match){
			delete user.password

			let token_id = uuidv4();
			user.token_id = token_id;

			token = jwt.sign(user, process.env.TOKEN_SECRET, { expiresIn: process.env.TOKEN_EXPIRES_IN });
			refresh_token = jwt.sign(user, process.env.REFRESH_TOKEN_SECRET, { expiresIn: process.env.REFRESH_TOKEN_EXPIRES_IN });

			let payload = jwt.decode(refresh_token);
			let expires_at = moment(payload.exp*1000).format("YYYY-MM-DD hh:mm:ss");

			const token_data = await RefreshToken.create({ id: token_id, token: refresh_token, data: JSON.stringify(user), expires_at: expires_at }).then( data => {
				return data !== null? data.dataValues: null
			}).catch( error => {

			});

			message = 'Login successfully'
		}else{
			success = false
			message = 'Wrong password'
		}
	}else{
		success = false
		message = 'User does not exist'
	}

	res.json({
		success: success,
		message: message,
		data: {
			token: token,
			refresh_token: refresh_token
		}
	});
}

/**
 * Description of method
 * @param  {[type]} req [description]
 * @param  {[type]} res [description]
 * @return {[type]}     [description]
 */
exports.refresh_token = async (req, res) => {
	let success = true
	let refresh_token = req.body.refresh_token
	let token = null
	let message = ''

	let tokenList = [];
	let find_refresh_token = await RefreshToken.findOne({where: {token: refresh_token}}).then( data => {
		return data !== null? data.dataValues: null
	}).catch( error => {})

	if (refresh_token && find_refresh_token !== null) {
		try {
			let verify = await Tools.verifyJwtToken(refresh_token, process.env.REFRESH_TOKEN_SECRET);

			if(verify){
				const user = JSON.parse(find_refresh_token.data);
			  	token = jwt.sign(user, process.env.TOKEN_SECRET, {
			    	expiresIn: process.env.TOKEN_EXPIRES_IN,
			  	});

			  	message = 'Refresh token success.'
			}
		} catch (err) {
			await RefreshToken.destroy({where: {token: refresh_token}});
		  	message = err.message;
		  	success = false;
		}
	} else {
		success = false;
		message = 'Invalid request.';
	}

	res.json({
		success: success,
		message: message,
		data: {
			token: token
		}
	});
}

/**
 * Get user info
 * @param  {Object} req [request]
 * @param  {Object} res [response]
 * @return {[type]}     [description]
 */
exports.info = async (req, res) => {
	const user_id = parseInt(req.user.id);
	let email = req.user.email
	req.user.avatar = gravatar.url(email);
	const user = await User.findByPk(user_id);
	user.checkAndSyncHeroes();
	
	const {heroes_mint, heroes_data} = await user.getHeroes();
	const non_nft_entries = await user.getNonNftEntries();
	const current_entries_calc = await user.getCurrentEntriesCalc();
	const submitted = await user.getSubmitted();
	const currentGame = await user.getCurrentGame();
	let game_playing_id = 0, game_id = 0;
	if(currentGame !== null){
		game_playing_id = currentGame.id;
		game_id = currentGame.game_id;
	}

	res.json({
		success: true,
		message: 'Data loaded',
		data: {
			game_playing_id: game_playing_id,
			game_id: game_id,
			user: req.user,
			heroes: heroes_mint,
			heroes_data: heroes_data,
			non_nft_entries: parseInt(non_nft_entries),
			current_entries: current_entries_calc,
			submitted: submitted
		}
	});
}

/**
 * Logout method
 * @param  {Object} req [description]
 * @param  {Object} res [description]
 * @return {[type]}     [description]
 */
exports.logout = async (req, res) => {
	res.json({
		success: true,
		message: 'message',
		data: null
	});
}

