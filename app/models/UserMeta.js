/**
 * UserMeta Model
 *
 * @param Request object $request Data.
 * @return JSON data
 */
var {Sequelize, sequelize} = require('../../config/sequelize.js');

var UserMeta = sequelize.define('UserMeta', {
	umeta_id: {
		type: Sequelize.BIGINT,
		allowNull: false,
		autoIncrement: true,
		primaryKey: true
	},
	user_id       	: Sequelize.BIGINT,
	meta_key       	: Sequelize.STRING,
	meta_value      : Sequelize.TEXT,
},{
	tableName    	: 'usermeta',
	timestamps   	: false,
	underscored  	: true
});

UserMeta._get = async (user_id, meta_key, single) => {
	let meta = await UserMeta.findOne({where: {user_id: user_id, meta_key: meta_key}}).then( _data => {
		return (_data !== null && _data.dataValues !== undefined)? _data.dataValues: null;
	}).catch( error => {
		console.log(error);
	})

	if(meta){
		return meta.meta_value;
	}

	return 0;
}


UserMeta._update = async (user_id, meta_key, meta_value) => {
	let meta = await UserMeta.findOrCreate({where: {user_id: user_id, meta_key: meta_key}, defaults: {meta_value: meta_value}}).then( async ([_data, created]) => {
		const meta = (_data !== null && _data.dataValues !== undefined)? _data.dataValues: null;
		const update = await UserMeta.update({meta_value: meta_value}, { where:{ umeta_id: parseInt(meta.umeta_id) }, silent: true});
		return update;
	});
	return meta;
}

module.exports = UserMeta;