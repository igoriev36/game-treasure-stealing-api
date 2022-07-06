//Store
var {Sequelize, cq_sequelize} = require('../../config/sequelize.js');
const { DataTypes } = require('sequelize');

var WoodlandRespite = cq_sequelize.define('WoodlandRespite', {
	token_number	: Sequelize.INTEGER,
	cosmetic_points	: Sequelize.INTEGER,
	stat_points		: Sequelize.INTEGER,
	ht_points_cp   	: {
        type: DataTypes.DECIMAL(7,3),
        defaultValue: 0.0,
        allowNull: false
    },
	ht_points_sp    : {
        type: DataTypes.DECIMAL(7,3),
        defaultValue: 0.0,
        allowNull: false
    },
	ht_points_total : {
        type: DataTypes.DECIMAL(7,3),
        defaultValue: 0.0,
        allowNull: false
    },
	hero_tier 		: Sequelize.STRING,
	legacy 			: {
        type: DataTypes.DECIMAL(7,3),
        defaultValue: 0.0,
        allowNull: false
    },
},{
	tableName    	: 'woodland_respite',
	createdAt    	: 'created_at',
	updatedAt    	: 'updated_at',
	timestamps   	: true,
	underscored  	: true
});

// Disable primary
WoodlandRespite.removeAttribute('id');

module.exports = WoodlandRespite;