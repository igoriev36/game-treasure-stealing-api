//Store
var {Sequelize, cq_sequelize} = require('../../config/sequelize.js');

var MetaData = cq_sequelize.define('MetaData', {
	id: {
		type: Sequelize.BIGINT,
		allowNull: false,
		autoIncrement: true,
		primaryKey: true
	},
	nft_id   		: Sequelize.INTEGER,
	stage       	: Sequelize.STRING,
	metadata_url	: Sequelize.STRING,
	image_url		: Sequelize.STRING
},{
	tableName    	: 'metadata',
	createdAt    	: 'created_at',
	updatedAt    	: 'updated_at',
	timestamps   	: true,
	underscored  	: true
});

module.exports = MetaData;