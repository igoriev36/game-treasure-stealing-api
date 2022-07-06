/**
 * Game Controller
 */
const Game = require('../../models/Game');

exports.loadGameHistory = async (req, res) => {
	const history_game = await Game.findAll({order: [['id', 'desc']]});
	let history = [];

	if(history_game !== null){
		history_game.forEach( game => {
			let tmp_game = game;
			tmp_game.id = parseInt(game.id);
			history.push(tmp_game);
		})
	}

	res.json({ 
		success: true,
		history: history
	});
}
