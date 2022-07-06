/**
 * Helper functions 
 */
const _ = require('lodash');
var moment = require('moment');
const format_date = 'YYYY-MM-DD 17:00:00';
const timezone = 'UTC';

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
    return {start_date: START, end_date: END}
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
    return {start_date: START, end_date: END}
};