/**
 * Class Solana
 * Author: os.solutionvn@gmail.com <Be Duc Tai>
 */

const { TOKEN_PROGRAM_ID, AccountLayout } = require("@solana/spl-token");
const parseArgs = require('minimist');
const web3 = require('@solana/web3.js');
const SOLANA_DECIMAL = 9;
const commitment = "confirmed";
let nodeType = "testnet";
const axios = require('axios').default;
const Option = require('../models/Option');

class Solana {
	constructor(){
		this.connection = null;
		this.rateURL = '';
		this.sol_usd_rate = 33.91;
	}

	async getSettings(){
		const rate = await Option._get('sol_usd_rate');
		let settings = await Option._get('solana_settings') || {};
		const default_settings = {
			node_type: 'testnet',
	        sol_usd_rate: rate,
	        auto_update_rate: true
		}
		return Object.assign({}, default_settings, settings);
	}

	async getNodeType(){
		const settings = await this.getSettings();
		return settings.node_type || nodeType;
	}

	async getConnection() {
		let node_type = await this.getNodeType();

	    if (!this.connection) {
	        try{
	        	this.connection = new web3.Connection(
		            web3.clusterApiUrl(node_type),
		            commitment,
		        );
	        }catch(error){}
	    }
	    return this.connection;
	}

	async getRemoteRate(type){
		if(typeof type === 'undefined'){
			type = 'usd-sol';
		}

		let type_arr = type.split('-');
		const to_currency = type_arr[0] || 'usd';
		this.rateURL = `https://api.coingecko.com/api/v3/simple/price?ids=solana&vs_currencies=${to_currency}`;
		let rate = this.sol_usd_rate;
		try{
			const result = await axios.get(this.rateURL);
			rate = result.data.solana.usd;
		}catch(err){
			// Hanlde errors
		}
		return rate;
	}

	async getRate(){
		const settings = await this.getSettings();
		if(!settings.auto_update_rate){
			return parseFloat(settings.sol_usd_rate);
		}
		return parseFloat(await Option._get('sol_usd_rate')) || this.sol_usd_rate;
	}

	/**
	 * Convert dollar to solana
	 * @param  float amount In dollar
	 * @param  string type   [from-to]
	 * @return float        Solana Coin
	 */
	async convert(amount, type){
		let rate = await this.getRate(type);
		return 1/rate*amount;
	}

	async updateSolRate(){
		const rate = await this.getRemoteRate();
		return await Option._update('sol_usd_rate', rate);
	}

	async getSolBalance(accountAddr) {
	    let connection = await this.getConnection();
	    if(!connection)
	    	return parseFloat('0').toFixed(6);
	    let account = new web3.PublicKey(accountAddr);
	    let accountBalance = await connection.getBalance(account);
	    let balance = (accountBalance/10**SOLANA_DECIMAL).toFixed(6);
	    return balance;
	}

	async requestAirdrop(address) {
	    let connection = await this.getConnection();
	    let account = new web3.PublicKey(address);

	    // Airdrop some SOL to the sender's wallet, so that it can handle the txn fee
	    var airdropSignature = await connection.requestAirdrop(
	        account,
	        web3.LAMPORTS_PER_SOL,
	    );

	    // Confirming that the airdrop went through
	    let resp = await connection.confirmTransaction(airdropSignature);
	    return resp;
	}

	// Transfer solana between accounts
	async transferSOL(fromPrivateKey, toAddress, amount) {
	    let connection = await this.getConnection();
	    let fromAccount = web3.Keypair.fromSeed(new Uint8Array(Buffer.from(fromPrivateKey, "hex")));
	    let toAccount = new web3.PublicKey(toAddress);
	    let lamports = (amount*web3.LAMPORTS_PER_SOL).toFixed(0);

	    // Add transfer instruction to transaction
	    var transaction = new web3.Transaction().add(
	        web3.SystemProgram.transfer({
	            fromPubkey: fromAccount.publicKey,
	            toPubkey: toAccount,
	            lamports: lamports,
	        })
	    );

	    // Sign transaction, broadcast, and confirm
	    var signature = await web3.sendAndConfirmTransaction(
	        connection,
	        transaction,
	        [fromAccount]
	    );
	    
	    return signature;
	}

	async getAmountBySignature(signature){
		let connection = await this.getConnection();
		let amount = 0;
		try{
			const check = await connection.getTransaction(signature);
			amount = check.meta.preBalances[0] - check.meta.postBalances[0];
			amount = amount / web3.LAMPORTS_PER_SOL;
			amount = amount.toFixed(4);
		}catch(e){}
		return amount;
	}

	async isValidTransaction(signature, wallet_address){
		let valid = false;
		let connection = await this.getConnection();
		try{
			const check = await connection.getTransaction(signature);
			if(check !== null && check.transaction.message.accountKeys[0].toString() === wallet_address){
				valid = true;
			}
		}catch(error){
			//Console.log(error)
		}
		return valid;
	}

	async getTokensByOwner(wallet_address){
		let connection = await this.getConnection();
		let response = await connection.getTokenAccountsByOwner(new web3.PublicKey(wallet_address), { programId: TOKEN_PROGRAM_ID, });
		let tokens = [];
		response.value.forEach((e) => {
			const token = e.pubkey.toBase58();
			tokens.push(token);
		});
		return tokens;
	}
}

module.exports = Solana;