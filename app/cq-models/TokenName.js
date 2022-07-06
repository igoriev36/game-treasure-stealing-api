//Store
var {Sequelize, cq_sequelize} = require('../../config/sequelize.js');

var TokenName = cq_sequelize.define('TokenName', {
	id: {
		type: Sequelize.BIGINT,
		allowNull: false,
		autoIncrement: true,
		primaryKey: true
	},
	nft_id   			: Sequelize.INTEGER,
	token_name       	: Sequelize.STRING,
	token_name_status	: Sequelize.STRING
},{
	tableName    	: 'token_names',
	createdAt    	: 'created_at',
	updatedAt    	: 'updated_at',
	timestamps   	: true,
	underscored  	: true
});

module.exports = TokenName;