//Store
var {Sequelize, sequelize} = require('../../config/sequelize.js');
const Token = require('../cq-models/Token');
const Character = require('../cq-models/Character');
const MetaData = require('../cq-models/MetaData');

var Hero = sequelize.define('Hero', {
	id: {
		type: Sequelize.BIGINT,
		allowNull: false,
		autoIncrement: true,
		primaryKey: true
	},
	mint          	: Sequelize.STRING, // token_address
	user_id 		: Sequelize.BIGINT,
	active			: Sequelize.INTEGER,
	extra_data		: Sequelize.JSON
},{
	tableName    	: 'heroes',
	//createdAt    	: 'created_at',
	//updatedAt    	: 'updated_at',
	timestamps   	: false,
	underscored  	: true
});

Hero.getTokenInfoByArr = async function(tokens_address){
	if(typeof tokens_address !== 'object')
		return null;
	return await Token.findAll({ include:[{model: Character, required:true},{model: MetaData, required:true}], where: {token_address: tokens_address} });
}

module.exports = Hero;