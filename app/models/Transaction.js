//Store
var {Sequelize, sequelize} = require('../../config/sequelize.js');
const User = require('../models/User');
const GamePlaying = require('../models/GamePlaying');

var Transaction = sequelize.define('Transaction', {
	id: {
		type: Sequelize.BIGINT,
		allowNull: false,
		autoIncrement: true,
		primaryKey: true
	},
	type          	: Sequelize.STRING,
	amount      	: Sequelize.FLOAT,
	event           : Sequelize.STRING,
	user_id 		: Sequelize.BIGINT,
	game_playing_id : Sequelize.BIGINT,
	game_id 		: Sequelize.BIGINT,
	description   	: Sequelize.TEXT,
  	signature   	: Sequelize.STRING,
  	token   		: Sequelize.STRING,
  	sol_cluster   	: Sequelize.STRING
},{
	tableName    	: 'game_transactions',
	createdAt    	: 'created_at',
	updatedAt    	: 'updated_at',
	timestamps   	: true,
	underscored  	: true
});

Transaction.hasOne(User, {
  	foreignKey: 'id',
  	targetKey: 'user_id'
});

Transaction.prototype.user = async function(){
	return await User.findByPk(parseInt(this.user_id));
}

Transaction.prototype.updatePrizeForUser = async function(prizeAmount){
	const user = await User.findByPk(parseInt(this.user_id));
	const game_playing_id = await user.getCurrentGameId();

	// await user.updateBalance(prizeAmount);

	if(game_playing_id){
		GamePlaying.update({finished: 1}, {where: {id: game_playing_id}});
		this.update({game_playing_id: game_playing_id});
		this.save();
	}
}

module.exports = Transaction;