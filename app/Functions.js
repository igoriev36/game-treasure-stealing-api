/**
 * Helper functions 
 */
var {Sequelize, sequelize, cq_sequelize} = require('../config/sequelize.js');
const _ = require('lodash');
var moment = require('moment');
const format_date = 'YYYY-MM-DD 17:00:00';
const timezone = 'UTC';
const Option = require('./models/Option');
const AdminWallet = require('./models/AdminWallet');

/**
 * [dateRange description]
 * @return {[type]} [description]
 */
module.exports.dateRange = function () { 
    const NOW = moment().tz(timezone).format('YYYY-MM-DD HH:MM:SS');
    let START = moment().tz(timezone).subtract(1, 'd').format(format_date);
    let END = moment().tz(timezone).format(format_date);
    if(END < NOW){
        START = END;
        END = moment().tz(timezone).add(1, 'd').format(format_date);
    }
    return {start_date: moment(START), end_date: moment(END)};
};

/**
 * [lastDateRange description]
 * @return {[type]} [description]
 */
module.exports.lastDateRange = function () { 
    const dateEndToday = moment().tz(timezone).format(format_date);
    const NOW = moment().tz(timezone).format('YYYY-MM-DD HH:MM:SS');
    let START = moment().tz(timezone).subtract(2, 'd').format(format_date);
    let END = moment().tz(timezone).subtract(1, 'd').format(format_date);
    if(dateEndToday < NOW){
        START = moment().tz(timezone).subtract(1, 'd').format(format_date);
        END = dateEndToday;
    }
    return {start_date: moment(START), end_date: moment(END)};
};

/**
 * [lastDateRange description]
 * @return {[type]} [description]
 */
module.exports.getExtraTicketsByToken = async function(token_address){
    const query = `SELECT T.token_address, C.* FROM characters as C, tokens as T WHERE C.nft_id = T.id AND T.token_address = '${token_address}'`;
    const CharacterInfo = await cq_sequelize.query(query, { type: cq_sequelize.QueryTypes.SELECT});
    let stats = {
        DexWisExtraTix: 0,
        ConStrExtraTix: 0,
        IntChaExtraTix: 0
    };
    if(CharacterInfo){
        const info = CharacterInfo[0];
        stats.DexWisExtraTix = Math.round(((info.dexterity+info.wisdom-20)/24)*10);
        stats.ConStrExtraTix = Math.round(((info.constitution+info.strength-20)/24)*7);
        stats.IntChaExtraTix = Math.round(((info.intelligence+info.charisma-20)/24)*3);
    }

    let point = 0;
    for (const [key, value] of Object.entries(stats)) {
        point += value;
    }
    console.log(point);
    return point;
}

/**
 * Get rate sol => usd from settings (this value will automatic update every minute)
 * @return float rate [Rate SOL>USD]
 */
module.exports.getRateSol = async function(){
    let rate = await Option._get('sol_usd_rate') || 1;
    rate = parseFloat(rate);
    return rate;
}

/**
 * Get primary wallet address from settings
 * @return {[type]} [description]
 */
module.exports.getPrimaryWallet = async function(){
    return await Option._get('primary_wallet');
}

/**
 * Get primary private key from a admin wallet
 * @return {[type]} [description]
 */
module.exports.getPrimaryPrivateKey = async function(){
    const wallet = await Option._get('primary_wallet');
    const find = await AdminWallet.findOne({where: {wallet_address: wallet}});
    if(find !== null)
        return find.private_key;
    return '';
}