/**
 * GameHelper Object Class
 */
var {Sequelize, sequelize, cq_sequelize} = require('../config/sequelize.js');
const Op = Sequelize.Op;
const Option = require('./models/Option');
const User = require('./models/User');
const Game = require('./models/Game');
const GamePlaying = require('./models/GamePlaying');
const Hero = require('./models/Hero');
const QuantityLookup = require('./models/QuantityLookup');
const HeroTierTicket = require('./models/HeroTierTicket');
const UserMeta = require('./models/UserMeta');
const Transaction = require('./models/Transaction');
const { Token, Character } = require('./cq-models');
var moment = require('moment');
const _ = require('lodash');
const { v4: uuidv4 } = require('uuid');
const fn = require('./Functions');
const { Solana } = require('./solana');

class GameHelper {

    constructor() {
        // Constructor
        this.unique_user_ids = [];
        this.total_user = 0;
        this.winning_users_count = 0;
        this.game_id = 0;
    }

    randomIntFromInterval(min, max) {
      return Math.floor(Math.random() * (max - min + 1) + min);
    }

    async getWakePercent(){
        let percent = await Option._get('wake_percent');
        return percent / 100;
    }

    async getSleepPercent(){
        let percent = await Option._get('sleep_percent');
        return percent / 100;
    }

    async getRawRakePercent(){
        let percent = await Option._get('raw_rake_percent');
        return percent / 100;
    }

    async initNewGame(){
        return await Game.create({data: {}, end: 0});
    }

    /**
     * Get Bonenosher Status
     * @return {string} [wake | sleep]
     */
    async getBonenosherStatus(){
        let status = '';
        const statusPercent = {
            wake: await Option._get('wake_percent'),
            sleep: await Option._get('sleep_percent')
        }
        const randPercent = this.randomIntFromInterval(1, 99);
        let start = 1;
        for (const [key, value] of Object.entries(statusPercent)) {
            const end = start + parseInt(value) - 1;
            if(start <= randPercent && randPercent <= end){
                status = key;
            }
            start += parseInt(value);
        }
        return status;
    }

    async getEffectiveRakePercent(){
        return await this.getRawRakePercent() * await this.getWakePercent();
    }

    // Stat for each hero
    async getHeroStatByToken(token){
        const query = `SELECT T.token_address, C.* FROM characters as C, tokens as T WHERE C.nft_id = T.id AND T.token_address = '${token}'`;
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
        return stats;
    }

    async getExtraTicketsfromHeroStats(token){
        const stats = await this.getHeroStatByToken(token);
        let point = 0;
        for (const [key, value] of Object.entries(stats)) {
            point += value;
        }
        return point;
    }

    /**
     * [resetGame description]
     * @return {[type]} [description]
     */
    async resetGame(){
        //Option._update('last_update_entry_calc', '{}');
        UserMeta.update({meta_value: 0}, {where: {meta_key: 'non_nft_entries'}});
        UserMeta.update(
            {meta_value: '{"TotalSpent":0,"entry_total":0,"ticket_total":0,"ChanceOfWinning":0,"ChanceNotWin":0,"NoRakeEV":0,"PostRakeEV":0}'}, 
            {where: {meta_key: 'current_entries_calc'}}
        );
        Hero.update({active:0},{where: {active: 1}});
    }

    /**
     * Prepare for the result calculation
     * @return {object} [Results]
     */
	async PrepareCalculation(){
        let self = this;

        const {start_date, end_date} = fn.dateRange();
        let games = [];

        if(this.game_id){
            games = await GamePlaying.findAll({where: {
                game_id: self.game_id,
                finished: 0
            }});
        }else{
            games = await GamePlaying.findAll({where: {
                created_at: { 
                    [Op.gt]: start_date,
                    [Op.lt]: end_date
                },
                finished: 0
            }});
        }

        let unique_user_ids = _.map(games, 'user_id');
        let game_submitted = _.map(games, 'submitted');
        unique_user_ids = unique_user_ids.map(function (id) { return parseInt(id); });

        // Query all hero active of all user submitted a game today
        const heroes = await Hero.findAll({where: {user_id: unique_user_ids, active: 1}});
        
        let tokens_address = heroes !== null? _.map(heroes, 'mint'): [];
        let total_user = unique_user_ids.length;
        this.unique_user_ids = unique_user_ids;
        this.total_user = total_user;

        var AVG_price_per_entry = 0.9;
        const hero_tier_nne = await HeroTierTicket.findOne({where: {tier: 'Non-NFT'}});
        //const non_nft_entries = await UserMeta.findAll({where: {user_id: unique_user_ids, meta_key: 'non_nft_entries'}});

        let entry_total_nne = 0;
        let ticket_total_nne = 0;
        let TotalSpent_nne = 0;
        let total_avg_price_per_entries = 0;
        let submitted_count = 0;
        game_submitted.forEach( submitted => {
            const last_sm = _.last(submitted);
            if(last_sm){
                submitted_count++;
                total_avg_price_per_entries += last_sm.price_per_entry;
            }
        });
        AVG_price_per_entry = total_avg_price_per_entries / submitted_count;

        game_submitted.forEach( submitted => {
            const last_sm = _.last(submitted);
            if(last_sm){
                let nne_no = last_sm.non_entry_total;
                entry_total_nne += nne_no;
                ticket_total_nne += nne_no * parseInt(hero_tier_nne.tickets);
                TotalSpent_nne += nne_no*AVG_price_per_entry;
            }
        });

        const tokens = await Token.findAll({where: {token_address: tokens_address}});
        let entry_calc = {};
        const EffectiveRake = await this.getEffectiveRakePercent();
        if(tokens && tokens.length > 0){
            let entry_total = 0;
            let ticket_total = 0;
            let TotalSpent = 0;
            
            let tokens_data = [];
            let extra_tix_obj = {};
            await Promise.all(tokens.map(async (token) => {
                let token_tmp = token;
                const token_info = await token.getExtraInfo();
                let entry_legacy = token_info.legacy;
                //entry_total += parseInt(entry_legacy);
                extra_tix_obj[token.token_address] = await self.getExtraTicketsfromHeroStats(token.token_address);
                entry_total++;
                token_tmp.token_info = token_info;
                tokens_data.push(token_tmp);
            }));

            // Get hero tier ticket data
            const hero_tier_data = await HeroTierTicket.findAll();
            tokens_data.forEach( token => {
                var var_of_hero_tier = _.chain(hero_tier_data).filter(function (h) { return h.tier === token.hero_tier }).first().value();
                const token_info = token.token_info;
                const legacy = token_info.legacy;
                // each hero is an entry
                let spent_per_hero = 1 * AVG_price_per_entry; // = Entries * Est. AVG Price / Entry
                let extra_tix = extra_tix_obj[token.token_address];
                let ticket_per_hero = var_of_hero_tier.tickets + extra_tix;
                TotalSpent += spent_per_hero;
                ticket_total += ticket_per_hero;
            });

            TotalSpent = TotalSpent + TotalSpent_nne;
            // Set data to property of object
            const PostRakePrizePool = (1-EffectiveRake)*TotalSpent;
            entry_calc.NoRakePrizePool = TotalSpent;
            entry_calc.PostRakePrizePool = PostRakePrizePool;
            entry_calc.entry_total = entry_total + entry_total_nne;
            entry_calc.ticket_total = ticket_total + ticket_total_nne;
            entry_calc.user_total = total_user;
            entry_calc.EstUsers = Math.round(entry_total/total_user);
            entry_calc.EstRakePerDay = TotalSpent - PostRakePrizePool;
        }else{
            const PostRakePrizePool = (1-EffectiveRake)*TotalSpent_nne;
            entry_calc.NoRakePrizePool = TotalSpent_nne;
            entry_calc.PostRakePrizePool = PostRakePrizePool;
            entry_calc.entry_total = entry_total_nne;
            entry_calc.ticket_total = ticket_total_nne;
            entry_calc.user_total = total_user;
            entry_calc.EstUsers = Math.round(entry_total_nne/total_user);
            entry_calc.EstRakePerDay = TotalSpent_nne - PostRakePrizePool;
        }

        // console.log(entry_calc)
        // Update this will use for single user calc [PostRake EV, NoRake EV]
        // Option._update('last_update_entry_calc', JSON.stringify(entry_calc));
        Game.getQueuedThieves(this.game_id);
        await Game.updateData({data: entry_calc}, this.game_id);

        return entry_calc;
    }

    /**
     * [calcTokenTimesQueued description]
     * @param  {[type]} game_id [description]
     * @return {[type]}         [description]
     */
    async calcTokenTimesQueued(game_id){
        game_id = game_id || 0;
        let default_extra_data = {
            times_queued: 0,
            times_won: 0,
            sol_earned: 0
        }

        if(!game_id)
            return;

        let games_playing = await GamePlaying.findAll({where: {game_id: game_id}});
        await Promise.all(games_playing.map( gplaying => {
            let last_submited = _.last(gplaying.submitted);
            let tokens_submited = last_submited.tokens;
            tokens_submited.forEach( async token => {
                const hero = await Hero.findOne({where: {mint: token}});
                let extra_data = hero.extra_data || {};
                extra_data = Object.assign({}, default_extra_data, extra_data);
                extra_data.times_queued++;
                await Hero.update({extra_data: extra_data}, {where: {mint: token} });
            });
        }));
    }

    /**
     * [PrizeCalc description]
     */
    async PrizeCalc(){
        const entry_calc = await this.PrepareCalculation();
        let users_count = entry_calc.user_total;
        let percent_of_user_paid = parseInt(await Option._get('percent_of_user_paid'));
        const winning_users = Math.round((users_count*percent_of_user_paid/100)+1);
        let max_prize = winning_users > 5? 5: winning_users;
        this.winning_users_count = winning_users;

        let prize_data = {};
        
        // % of winning users 0.40% | 1.14% | 3.79% | 6.95% | 87.73%
        let percent_of_winning_users = [1/winning_users*100,1.1364,3.79,6.95,87.73];
        let percent_of_bounty = [25,15,17,10,33];

        /*
         66% Wake 33% Sleep
         On sleep 80% pot goes to users by raffle (25% of unique wallets) 20% rolls over to next day. Entries reset.
         On wake 66% of pot rolls over to next day. 33% raked. Entries roll over too.
         */
        let paidOut = 0;
        let raked = 0;
        let rakePrizeNextDay = 0;
        let bonenosher_status = await this.getBonenosherStatus();

        // Get rake price last day
        const backPot = await Game.getBackPot(this.game_id) || 0; // Get from yesterday game
        
        if(bonenosher_status === 'sleep'){
            paidOut = entry_calc.NoRakePrizePool*80/100;
            rakePrizeNextDay = entry_calc.NoRakePrizePool*20/100;
            paidOut = paidOut + parseFloat(backPot);
        }else{
            paidOut = 0;
            raked = entry_calc.NoRakePrizePool*33/100; // Game fee CQ
            rakePrizeNextDay = entry_calc.NoRakePrizePool*66/100;
            rakePrizeNextDay = rakePrizeNextDay + parseFloat(backPot);
        }

        // Update token Times queued
        await this.calcTokenTimesQueued(this.game_id);
        // Store in database
        await Game.updateData({result: bonenosher_status, back_pot: rakePrizeNextDay, raked: raked}, this.game_id);

        for(var i=0; i<max_prize; i++){
            let no_of_winning_wallets = i === 0? percent_of_winning_users[i]/100*winning_users: Math.round(percent_of_winning_users[i]/100*winning_users);
            let bounty = percent_of_bounty[i]/100*paidOut;
            let prize = 0;
            if(no_of_winning_wallets !== 0){
                prize = i === 0? bounty: bounty/no_of_winning_wallets;
            }
            prize_data[`pos_${i+1}`] = {
                prize: prize,
                bounty: Math.round(bounty),
                number_of_winning_wallets: no_of_winning_wallets,
                percent_of_winning_users: percent_of_winning_users[i],
                percent_of_bounty: percent_of_bounty[i]
            }
        }

        return prize_data;
    }

    /**
     * [PrizesDistribution description]
     * The function should just pull random tickets until all [winners] prizes are distributed
     */
    async PrizesDistribution(game_id){
        if(typeof game_id !== 'undefined'){
            this.game_id = parseInt(game_id);
        }else{
            game_id = this.game_id !== 0? this.game_id: 0;
        }

        const prize_data = await this.PrizeCalc();
        let user_ids = this.unique_user_ids;
        const fromPrivateKey = await fn.getPrimaryPrivateKey();
        const winning_users_count = this.winning_users_count;
        const rate = await fn.getRateSol();
        const Sol = new Solana();

        for (const [key, prize] of Object.entries(prize_data)) {
            const user_count = Math.round(prize.number_of_winning_wallets);
            for(var i=0;i<user_count;i++){
                // Get an user from unique user ids
                var user_id = user_ids[Math.floor(Math.random()*user_ids.length)];
                // After the user_id has been paid, remove that user_id from the reward array
                user_ids = user_ids.filter(function(id){ return id != user_id; });

                if(prize.prize > 0){
                    // Create transaction for prize
                    let amount = 1/rate * parseFloat(prize.prize);
                    amount = amount.toFixed(4);
                    amount = parseFloat(amount);
                    
                    const toAddress = await User.getWalletAddressById(user_id);
                    try{
                        const signature = await Sol.transferSOL(fromPrivateKey, toAddress, amount);
                        if(signature){
                            const user = await User.findByPk(parseInt(user_id));

                            const game = await user.getCurrentGame(game_id);
                            const playing_game_id = game !== null? parseInt(game.id): 0;
                            
                            let ran_token = '';

                            if(playing_game_id){
                                let last_submited = _.last(game.submitted);
                                let tokens_submited = last_submited.tokens;
                                // Random token (hero) win game
                                ran_token = tokens_submited[Math.floor(Math.random()*tokens_submited.length)];

                                // Handle set the token times queued
                                await Promise.all(tokens_submited.map(async (token) => {
                                    const hero = await Hero.findOne({where: {mint: token}});

                                    /*
                                    +Times Queued (DB stores everytime user pays with that hero)
                                    +Times Won (DB Stores everytime they win SOL)
                                    +SOL Earned (DB Stores how much total they've won)
                                    */
                                    let times_queued = 0;
                                    let times_won = 0;
                                    let sol_earned = 0;

                                    if(hero !== null){
                                        let extra_data = hero.extra_data || {};
                                        if(typeof extra_data === 'object' && extra_data !== null){
                                            //console.log(token, ran_token);
                                            if(token === ran_token){
                                                times_won += extra_data.times_won;
                                                sol_earned = extra_data.sol_earned + amount;
                                            }else{
                                                times_won = extra_data.times_won;
                                                sol_earned = extra_data.sol_earned;
                                            }
                                        }

                                        // Update hero (token) stats
                                        extra_data = Object.assign({}, extra_data, {
                                            times_won: times_won,
                                            sol_earned: sol_earned
                                        });
                                        Hero.update({extra_data: extra_data}, {where: {mint: token} });
                                    }
                                }));

                                GamePlaying.update({finished: 1, winning_hero: ran_token}, {where: {id: playing_game_id}});
                            }

                            const sol_cluster = await fn.getSolCluster();
                            const transaction = await Transaction.create({
                                type: 'prize',
                                amount: amount,
                                event: `prize_for_${key}`,
                                user_id: user_id,
                                description: `Reward SOL ${amount} for user_id = ${user_id} `,
                                signature: signature,
                                game_playing_id: playing_game_id,
                                game_id: game_id,
                                token: ran_token,
                                sol_cluster: sol_cluster
                            });
                        }
                    }catch(error){
                        console.log(error);
                    }
                }
            }
        }

        await Game.setEndGame(game_id);
        await Hero.resetStatus();

        return true;
    }

    async endGame(game_id){
        await this.PrizesDistribution(parseInt(game_id));
    }
}

module.exports = GameHelper;