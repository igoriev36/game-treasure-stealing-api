//Store
var {Sequelize, cq_sequelize} = require('../../config/sequelize.js');
const TokenName = require('./TokenName');
const Character = require('./Character');
const MetaData = require('./MetaData');
const DawnOfMan = require('./DawnOfMan');
const WoodlandRespite = require('./WoodlandRespite');

var Token = cq_sequelize.define('Token', {
	id: {
		type: Sequelize.BIGINT,
		allowNull: false,
		autoIncrement: true,
		primaryKey: true
	},
	token_address   : Sequelize.STRING,
	mint_name       : Sequelize.STRING,
	tome          	: Sequelize.STRING,
	mint_number		: Sequelize.INTEGER,
	token_number	: Sequelize.INTEGER,
	stat_points		: Sequelize.INTEGER,
	cosmetic_points	: Sequelize.INTEGER,
	stat_tier 		: Sequelize.STRING,
	cosmetic_tier 	: Sequelize.STRING,
	hero_tier 		: Sequelize.STRING
},{
	tableName    	: 'tokens',
	createdAt    	: 'created_at',
	updatedAt    	: 'updated_at',
	timestamps   	: true,
	underscored  	: true
});

Token.hasOne(TokenName, {
  	foreignKey: 'nft_id',
  	targetKey: 'token_address'
});

Token.hasOne(Character, {
  	foreignKey: 'nft_id',
  	targetKey: 'token_address'
});

Token.hasMany(MetaData, {
	as: 'meta',
  	foreignKey: 'nft_id',
  	targetKey: 'token_address'
});

Token.prototype.getExtraInfo = async function(){
	const tome = this.tome;
	let info = null;
	if(tome.indexOf('Dawn of Man') > -1){
		info = await DawnOfMan.findOne({where: {token_number: this.token_number}});
	}else{
		info = await WoodlandRespite.findOne({where: {token_number: this.token_number}});
	}
	return info;
}

module.exports = Token;