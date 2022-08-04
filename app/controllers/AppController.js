/**
 * APP Controller
 */

const Option = require('../models/Option');
const Token = require('../cq-models/Token');
const DawnOfMan = require('../cq-models/DawnOfMan');
const User = require('../models/User');
const Game = require('../models/Game');
const GameHelper = require('../GameHelper');
const GameSimulatorTest = require('../GameSimulatorTest');
const fn = require('../Functions');
var moment = require('moment');
const _ = require('lodash');
const { SolanaWallet, Solana } = require('../solana');

exports.dev = async (req, res) => {
	//const user = await User.findByPk(1);
	//const game_info = await user.getCalGameInfo();
	//console.log(game_info);
	//
	//const dr = fn.lastDateRange();
	//console.log(dr);
	
	// const helper = new GameHelper();
	// let data = await helper.PrizeCalc();
	// console.log(data);
	// req.app.io.of('gts.dashboard').emit('game_update', {
	// 	data: data
	// });
	// 
	// const day1 = moment().tz('UTC').subtract(1, 'd').format('YYYY-MM-DD 17:00:00');
	// const day2 = moment().tz('UTC').subtract(2, 'd').format('YYYY-MM-DD 17:00:00');

	//console.log(day1, day2);
	
	// const simulator = new GameSimulatorTest();
	// await simulator.createGameForAllUser();
	// 
	// const SW = new SolanaWallet();
	// const info = await SW.getWalletInfo('wage auto fluid sketch solar news pear profit soon ladder drama various');
	// console.log(info);
	//const Sol = new Solana();
	const test = await new Solana().getTokensByOwner('26kuD3FoQreG6Q1B3KgajhPPhYcgEf2waam5hcdjDVd5'); console.log(test);
	
	res.render('dev', { title: '4Dev' });
}

exports.getGameInfo = async (req, res) => {
	const Sol = new Solana();
	const now = moment().tz('UTC').format('YYYY-MM-DD HH:MM:SS');
	let wake_time = moment().tz('UTC').format('YYYY-MM-DD 17:00:00');

	if(wake_time < now){
		wake_time = moment().add(1,'d').tz('UTC').format('YYYY-MM-DD 17:00:00');
	}

	var duration = moment.duration(moment(wake_time).tz('UTC').diff(now));
    const seconds = duration.asSeconds();
    let current_game = await Game.getTodayGame();

    let data = {};
    if(current_game !== null){
    	data = current_game.data;
    }else{
    	current_game = await Game.create({data: {}, end: 0, thieves_count: 0});
    }

    const {main_pot, bonus} = await Game.getPot();

	const game_info = {
		time_now: now,
		wake_time: wake_time,
		seconds: seconds,
		bonenosher_bounty: {
			total: main_pot,
			loose: bonus
		},
		queued_thieves: current_game.thieves_count || 0,
		active_thieves: 0,
		thieves_guide_standing: {
			active: 0,
			total: 0
		}
	};

	const sol_usd_rate = await fn.getRateSol();
	const primary_wallet = await fn.getPrimaryWallet();

	res.json({ 
		success: true,
		node_type: await Sol.getNodeType(),
		sol_usd_rate: sol_usd_rate,
		primary_wallet: primary_wallet,
		game_info: game_info
	});
}