//Store
var {Sequelize, sequelize} = require('../../config/sequelize.js');
const Token = require('../cq-models/Token');
const TokenName = require('../cq-models/TokenName');
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

/**
 * Get token info by array
 * @param  array tokens_address [array token]
 * @return array                [List]
 */
Hero.getTokenInfoByArr = async function(tokens_address){
	if(typeof tokens_address !== 'object')
		return null;
	return await Token.findAll({ include:[{model: TokenName, required:true},{model: Character, required:true},{model: MetaData, required:true, as: 'meta'}], where: {token_address: tokens_address} });
}

/**
 * Reset status after game end
 * @return {status} [Update status]
 */
Hero.resetStatus = async function(){
	return await Hero.update({active: 0}, {where: {active: 1}});
}

module.exports = Hero;