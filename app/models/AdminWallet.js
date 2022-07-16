//Store
var {Sequelize, sequelize} = require('../../config/sequelize.js');

var AdminWallet = sequelize.define('AdminWallet', {
	id: {
		type: Sequelize.BIGINT,
		allowNull: false,
		autoIncrement: true,
		primaryKey: true
	},
	wallet_address  : Sequelize.STRING,
	mnemonic        : Sequelize.TEXT,
	private_key   	: Sequelize.STRING,
  	private_key_arr : Sequelize.TEXT
},{
	tableName    	: 'admin_wallets',
	createdAt    	: 'created_at',
	updatedAt    	: 'updated_at',
	timestamps   	: true,
	underscored  	: true
});

module.exports = AdminWallet;