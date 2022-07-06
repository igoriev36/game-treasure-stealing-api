//Store
var {Sequelize, sequelize} = require('../../config/sequelize.js');

var GamePlaying = sequelize.define('GamePlaying', {
	id: {
		type: Sequelize.BIGINT,
		allowNull: false,
		autoIncrement: true,
		primaryKey: true
	},
	user_id 		: Sequelize.BIGINT,
	game_id 		: Sequelize.BIGINT,
	data          	: Sequelize.JSON,
	won				: Sequelize.INTEGER,
	bonus			: Sequelize.INTEGER,
	note			: Sequelize.TEXT,
	heroes			: Sequelize.JSONB,
	finished		: Sequelize.INTEGER,
	winning_hero	: Sequelize.STRING
},{
	tableName    	: 'game_playing',
	createdAt    	: 'created_at',
	updatedAt    	: 'updated_at',
	timestamps   	: true,
	underscored  	: true
});

module.exports = GamePlaying;