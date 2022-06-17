//Store
var {Sequelize, sequelize} = require('../../config/sequelize.js');

var Hero = sequelize.define('Hero', {
	id: {
		type: Sequelize.BIGINT,
		allowNull: false,
		autoIncrement: true,
		primaryKey: true
	},
	mint          	: Sequelize.STRING,
	user_id 		: Sequelize.BIGINT,
	active			: Sequelize.INTEGER
},{
	tableName    	: 'heroes',
	//createdAt    	: 'created_at',
	//updatedAt    	: 'updated_at',
	timestamps   	: false,
	underscored  	: true
});

module.exports = Hero;