//Store
var {Sequelize, sequelize} = require('../../config/sequelize.js');

var Admin = sequelize.define('Admin', {
	id: {
		type: Sequelize.BIGINT,
		allowNull: false,
		autoIncrement: true,
		primaryKey: true
	},
	username          	: Sequelize.STRING,
	email           	: Sequelize.STRING,
	password   			: Sequelize.STRING,
	active      	    : Sequelize.INTEGER,
  	avatar_url   		: Sequelize.STRING
},{
	tableName    	: 'admins',
	createdAt    	: 'created_at',
	updatedAt    	: 'updated_at',
	timestamps   	: true,
	underscored  	: true
});

module.exports = Admin;