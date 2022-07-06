
//Store
var {Sequelize, sequelize} = require('../../config/sequelize.js');

var QuantityLookup = sequelize.define('QuantityLookup', {
	id: {
		type: Sequelize.BIGINT,
		allowNull: false,
		autoIncrement: true,
		primaryKey: true
	},
	type          	: Sequelize.STRING,
	quantity_from   : Sequelize.INTEGER,
	value  			: Sequelize.FLOAT
},{
	tableName    	: 'quantity_lookup',
	timestamps   	: false,
	underscored  	: true
});

module.exports = QuantityLookup;