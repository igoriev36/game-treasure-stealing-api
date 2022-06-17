var {Sequelize, sequelize} = require('../../config/sequelize.js');
const Tools = require('../Tools');

var Options = sequelize.define('Options', {
	id: {
		type: Sequelize.BIGINT,
		allowNull: false,
		autoIncrement: true,
		primaryKey: true
	},
	option_name     : Sequelize.STRING,
	option_value    : Sequelize.TEXT,
	autoload       	: Sequelize.BOOLEAN,
},{
	tableName    	: 'options',
	timestamps   	: false,
	underscored  	: true
});

Options._get = async function(option_name){
	if(typeof option_name !== 'string')
		return false;

	let option_value = await Options.findOne({where: {option_name: option_name}}).then( _data => {
		return (_data !== null && _data.dataValues !== undefined)? _data.dataValues.option_value: null;
	}).catch( error => {
		return null;
	});
	return Tools.maybe_unserialize(option_value);
}

Options._update = async function(option_name, option_value){
	if(option_name === undefined || option_value === undefined)
		return false;

	option_value = Tools.maybe_serialize(option_value);
	return await Options.findOrCreate({where: {option_name: option_name}, defaults: {option_value: option_value}}).then( async ([_data, created]) => {
		const option = (_data !== null && _data.dataValues !== undefined)? _data.dataValues: null;
		return await Options.update({option_value: option_value}, { where:{ id: parseInt(option.id) }, silent: true});
	});
}

Options._delete = async function(option_name, option_value){
	if(option_name === undefined)
		return false;

	let _where = {
		option_name: option_name
	}

	if(typeof option_value !== 'undefined'){
		_where = Object.assign({}, _where, {option_value: option_value})
	}

	return Options.destroy({ where: _where });
}

module.exports = Options;