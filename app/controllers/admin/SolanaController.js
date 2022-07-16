/**
 * Settings Controller
 */
const _ = require('lodash');
const Option = require('../../models/Option');
const AdminWallet = require('../../models/AdminWallet');
const { SolanaWallet, Solana } = require('../../solana');

exports.loadWallets = async (req, res) => {
	const walles = await AdminWallet.findAll({order: [['id', 'DESC']]});
	const primary_wallet = await Option._get('primary_wallet');
	let settings = {};
	let walles_data = [];

	walles.forEach( wallet => {
		let _wallet = wallet.dataValues;
		let is_primary = (primary_wallet === _wallet.wallet_address)? true: false;
		_wallet.is_primary = is_primary;
		walles_data.push(_wallet);
	});

	settings = await Option._get('solana_settings');
	let sol_usd_rate = await Option._get('sol_usd_rate');
	sol_usd_rate = parseFloat(sol_usd_rate);

	if(!settings){
		settings = {
			auto_update_rate: true,
			node_type: 'testnet',
			sol_usd_rate: ''
		}
	}

	settings.sol_usd_rate = sol_usd_rate;

	res.json({ 
		success: true,
		settings: settings,
		walles: walles_data
	});
}

exports.getBalanceWallets = async (req, res) => {
	const wallets = await AdminWallet.findAll({order: [['id', 'DESC']]});
	const Sol = new Solana();
	let balance_wallets = {};

	await Promise.all(wallets.map(async (wallet) => {
		const balance = await Sol.getSolBalance(wallet.wallet_address);
		balance_wallets[wallet.wallet_address] = balance;
    }));

	res.json({ 
		success: true,
		balance_wallets: balance_wallets
	});
}

exports.generateWallet = async (req, res) => {
	const SW = new SolanaWallet();
	const wallet_data = await SW.generateWallet();

	await AdminWallet.create({
		wallet_address: wallet_data.wallet,
		mnemonic: wallet_data.mnemonic,
		private_key: wallet_data.private_key,
		private_key_arr: wallet_data.private_key_arr
	});

	res.json({ 
		success: true,
		wallet_data: wallet_data
	});
}

exports.setPrimaryWallet = async (req, res) => {
	const id = req.body.id || 0;
	const wallet_data = await AdminWallet.findByPk(id);
	const wallet_address = wallet_data.wallet_address || '';
	if(wallet_address){
		await Option._update('primary_wallet', wallet_address);
	}

	res.json({ 
		success: true,
		id: id
	});
}

exports.checkWalletInfo = async (req, res) => {
	let key_val = req.body.key_val;
	let type = req.body.type;
	let check = {};
	let success = true;
	let message = '';
	const SW = new SolanaWallet();


	if(type === 'mnemonic'){
		check = await SW.getWalletInfo(key_val);
	}else if(type === 'private-key'){
		try{
			check = await SW.checkAccount(key_val);
		}catch(error){
			success = false;
			message = error.message;
		}
	}

	if(!_.isEmpty(check)){
		const find = await AdminWallet.findOne({where: {wallet_address: check.wallet}});
		if(find){
			check.exist = true;
		}else{
			check.exist = false;
		}
	}

	res.json({ 
		success: success,
		message: message,
		check: check
	});
}

exports.addWallet = async (req, res) => {
	let wallet_data = req.body.wallet_data || {};
	let success = true;
	let message = '';

	if(!_.isEmpty(wallet_data)){
		const wallet_address = wallet_data.wallet_address;
		const find = await AdminWallet.findOne({where: {wallet_address: wallet_data.wallet_address}});
		if(!find){
			await AdminWallet.create({
				wallet_address: wallet_data.wallet_address,
				mnemonic: wallet_data.mnemonic,
				private_key: wallet_data.private_key,
				private_key_arr: wallet_data.private_key_arr
			});
		}else{
			success = false;
			message = 'Wallet exist!'
		}
	}

	res.json({ 
		success: success,
		message: message
	});
}

exports.updateSettings = async (req, res) => {
	let settings = req.body.settings || {};
	if(!_.isEmpty(settings)){
		await Option._update('solana_settings', settings);
	}

	res.json({ 
		success: true
	});
}