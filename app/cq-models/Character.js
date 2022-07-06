//Store
var {Sequelize, cq_sequelize} = require('../../config/sequelize.js');

var Character = cq_sequelize.define('Character', {
	id: {
		type: Sequelize.BIGINT,
		allowNull: false,
		autoIncrement: true,
		primaryKey: true
	},
	nft_id			: Sequelize.INTEGER,
	token_id		: Sequelize.STRING,
	constitution	: Sequelize.INTEGER,
	strength		: Sequelize.INTEGER,
	dexterity		: Sequelize.INTEGER,
	wisdom			: Sequelize.INTEGER,
	intelligence	: Sequelize.INTEGER,
	charisma		: Sequelize.INTEGER,
	race 			: Sequelize.STRING,
	sex				: Sequelize.STRING,
	face_style		: Sequelize.STRING,
	skin_tone		: Sequelize.STRING,
	eye_detail		: Sequelize.STRING,
	eyes			: Sequelize.STRING,
	facial_hair		: Sequelize.STRING,
	glasses			: Sequelize.STRING,
	hair_style		: Sequelize.STRING,
	hair_color		: Sequelize.STRING,
	necklace		: Sequelize.STRING,
	earring			: Sequelize.STRING,
	nose_piercing	: Sequelize.STRING,
	scar			: Sequelize.STRING,
	tattoo			: Sequelize.STRING,
	background		: Sequelize.STRING
},{
	tableName    	: 'characters',
	createdAt    	: 'created_at',
	updatedAt    	: 'updated_at',
	timestamps   	: true,
	underscored  	: true
});

module.exports = Character;