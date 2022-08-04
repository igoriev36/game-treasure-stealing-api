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

        const {start_date, end_date} = fn.dateRange(); //console.log(start_date, end_date )
        const games = await GamePlaying.findAll({where: {
            created_at: { 
                [Op.gt]: start_date,
                [Op.lt]: end_date
            },
            finished: 0
        }});
        //console.log(games);
        let unique_user_ids = _.map(games, 'user_id');
        unique_user_ids = unique_user_ids.map(function (id) { return parseInt(id); });

        // Query all hero active of all user submitted a game today
        const heroes = await Hero.findAll({where: {user_id: unique_user_ids, active: 1}});
        
        let tokens_address = heroes !== null? _.map(heroes, 'mint'): [];
        let total_user = unique_user_ids.length;
        this.unique_user_ids = unique_user_ids;
        this.total_user = total_user;

        const AVG_price_per_entry = 0.9;
        const hero_tier_nne = await HeroTierTicket.findOne({where: {tier: 'Non-NFT'}});
        const non_nft_entries = await UserMeta.findAll({where: {user_id: unique_user_ids, meta_key: 'non_nft_entries'}});
        let entry_total_nne = 0;
        let ticket_total_nne = 0;
        let TotalSpent_nne = 0;
        non_nft_entries.forEach( nne => {
            const nne_no = parseInt(nne.meta_value);
            entry_total_nne += nne_no;
            ticket_total_nne += nne_no * parseInt(hero_tier_nne.tickets);
            TotalSpent_nne += nne_no*AVG_price_per_entry;
        });

        const tokens = await Token.findAll({where: {token_address: tokens_address}});
        let entry_calc = {};
        const EffectiveRake = await this.getEffectiveRakePercent();
        if(tokens && tokens.length > 0){
            let entry_total = 0;
            let ticket_total = 0;
            let TotalSpent = 0;
            
            let tokens_data = [];
            await Promise.all(tokens.map(async (token) => {
                let token_tmp = token;
                const token_info = await token.getExtraInfo();
                let entry_legacy = token_info.legacy;
                //entry_total += parseInt(entry_legacy);
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
                let spent_per_hero = AVG_price_per_entry;
                let extra_tix = var_of_hero_tier.tix_from_stats;
                let ticket_per_hero = var_of_hero_tier.tickets + extra_tix;
                TotalSpent += spent_per_hero;
                ticket_total += ticket_per_hero;
            });

            // Set data to property of object
            const PostRakePrizePool = (1-EffectiveRake)*TotalSpent;
            entry_calc.NoRakePrizePool = TotalSpent + TotalSpent_nne;
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

        // Update this will use for single user calc [PostRake EV, NoRake EV]
        // Option._update('last_update_entry_calc', JSON.stringify(entry_calc));
        Game.getQueuedThieves();
        await Game.updateData({data: entry_calc});

        return entry_calc;
    }

    /**
     * [PrizeCalc description]
     */
    async PrizeCalc(){
        const entry_calc = await this.PrepareCalculation(); //console.log(entry_calc);
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
        if(bonenosher_status === 'sleep'){
            paidOut = entry_calc.NoRakePrizePool*80/100;
            rakePrizeNextDay = entry_calc.NoRakePrizePool*20/100;
        }else{
            paidOut = 0;
            raked = entry_calc.NoRakePrizePool*33/100; // Game fee CQ
            rakePrizeNextDay = entry_calc.NoRakePrizePool*66/100;
        }

        // Get rake price last day
        const backPot = await Game.getBackPot() || 0; // Get from yesterday game
        paidOut = paidOut + parseFloat(backPot);

        // Store in database
        await Game.updateData({result: bonenosher_status, back_pot: rakePrizeNextDay, raked: raked});

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
    async PrizesDistribution(){
        const prize_data = await this.PrizeCalc(); console.log(prize_data);
        let user_ids = this.unique_user_ids;
        const fromPrivateKey = await fn.getPrimaryWallet();
        const winning_users_count = this.winning_users_count;
        const rate = await parseFloat(fn.getRateSol());
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
                    amount = amount.toFixed(2);
                    
                    const toAddress = await User.getWalletAddressById(user_id);
                    const signature = await Sol.transferSOL(fromPrivateKey, toAddress, amount);
                    if(signature){
                        const transaction = await Transaction.create({
                            type: 'prize',
                            amount: amount,
                            event: `prize_for_${key}`,
                            user_id: user_id,
                            description: '',
                            signature: signature,
                            game_id: null
                        });
                        await transaction.updatePrizeForUser(prize.prize);
                    }
                }
            }
        }

        await Game.setEndGame();

        return true;
    }
}

module.exports = GameHelper;