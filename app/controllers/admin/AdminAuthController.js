const User = require('../../models/Admin');
const RefreshToken = require('../../models/RefreshToken');

//var qs = require('qs');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
var gravatar = require('gravatar');
const Tools = require('../../Tools');
const { v4: uuidv4 } = require('uuid');
var moment = require('moment'); // require

/**
 * Connect wallet method
 * @param  {Object} req [description]
 * @param  {Object} res [description]
 * @return {[type]}     [description]
 */
exports.connect_wallet = async (req, res) => {
	res.json({ 
		success: true
	});
}

/**
 * Login method
 * @param  {Object} req [description]
 * @param  {Object} res [description]
 * @return {[type]}     [description]
 */
exports.login = async (req, res) => {
	let username = req.body.username
	let password = req.body.password
	let success = true
	let token = null
	let refresh_token = null
	let message = ''

	let user = await User.findOne({where: {username: username}}).then( res => {
		return res !== null? res.dataValues: null
	}).catch( () => {
		return null
	})

	if(user !== null){
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

	res.json({
		success: true,
		message: 'Load user info success',
		data: req.user
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

