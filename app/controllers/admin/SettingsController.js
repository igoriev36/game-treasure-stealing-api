/**
 * Settings Controller
 */
const _ = require('lodash');
const Option = require('../../models/Option');

exports.loadSettings = async (req, res) => {
	const game_settings = await Option._get('game_settings') || {};
	res.json({ 
		success: true,
		game_settings: game_settings
	});
}

exports.updateSettings = async (req, res) => {
	let settings = req.body.settings || {};
	if(!_.isEmpty(settings)){
		const game_settings = await Option._get('game_settings');
		if(typeof game_settings === 'object'){
			settings = Object.assign({}, game_settings, settings );
		}
		Option._update('game_settings', settings);
	}

	res.json({ 
		success: true
	});
}