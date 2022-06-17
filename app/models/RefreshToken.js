//Store
var {Sequelize, sequelize} = require('../../config/sequelize.js');

var RefreshToken = sequelize.define('RefreshToken', {
	id: {
		type: Sequelize.STRING,
		allowNull: false,
		primaryKey: true
	},
	token        	: Sequelize.TEXT,
	data   			: Sequelize.TEXT,
	expires_at   	: Sequelize.DATE
},{
	tableName    	: 'auth_refresh_tokens',
	createdAt    	: 'created_at',
	updatedAt    	: 'updated_at',
	timestamps   	: false,
	underscored  	: true
});

module.exports = RefreshToken;