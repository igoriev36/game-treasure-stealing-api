/**
 * Class Solana Coin
 * Author: os.solutionvn@gmail.com <Be Duc Tai>
 */
const parseArgs = require('minimist');
const Web3 = require('@solana/web3.js');
const bip39 = require('bip39');
const { derivePath } = require('ed25519-hd-key');

const DERIVATION_PATH = "m/44'/501'/0'/0'";          // m/44'/501'/${walletIndex}'/0'

class SolanaWallet {

	constructor() {
		//constructor
		this.derivation_path = DERIVATION_PATH;
	}

	async getWalletInfo(mnemonic) {
	    let seed = await bip39.mnemonicToSeed(mnemonic);
	    let privateKey = derivePath(DERIVATION_PATH, seed).key;
	    let account = Web3.Keypair.fromSeed(new Uint8Array(privateKey));
	    return {
	    	mnemonic: mnemonic,
	    	private_key: privateKey.toString('hex'),
	    	private_key_arr: "[" + privateKey.join(",") + "]",
	    	wallet: account.publicKey.toBase58()
	    };
	}

	async generateWallet() {
	    let mnemonic = bip39.generateMnemonic(256);
	    return this.getWalletInfo(mnemonic);
	}

	async generateAccount() {
	    let account = Web3.Keypair.generate();
	    let privateKey = Buffer.from(account.secretKey).slice(0, 32);
	    return {
	    	private_key: privateKey.toString('hex', 0, 32),
	    	private_key_arr: "[" + privateKey.join(",") + "]",
	    	wallet: account.publicKey.toBase58()
	    };
	}

	async checkAccount(privateKey) {
	    if (privateKey.startsWith("[") && privateKey.endsWith("]")) {
	        privateKey = Buffer.from(eval(privateKey));
	    } else {
	        privateKey = Buffer.from(privateKey, "hex");
	    }
	    let account = Web3.Keypair.fromSeed(new Uint8Array(privateKey));
	    return {
	    	private_key: privateKey.toString('hex'),
	    	private_key_arr: "[" + privateKey.join(",") + "]",
	    	wallet: account.publicKey.toBase58()
	    };
	}
}

module.exports = SolanaWallet;