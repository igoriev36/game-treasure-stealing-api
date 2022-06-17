//Store
var {Sequelize, sequelize} = require('../../config/sequelize.js');

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
	user_id 		: Sequelize.DATE,
	description   	: Sequelize.TEXT,
  	uid   			: Sequelize.STRING
},{
	tableName    	: 'game_transactions',
	createdAt    	: 'created_at',
	updatedAt    	: 'updated_at',
	timestamps   	: true,
	underscored  	: true
});

module.exports = Transaction;