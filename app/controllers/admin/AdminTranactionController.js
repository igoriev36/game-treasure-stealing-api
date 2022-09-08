/**
 * Transaction Controller
 */
const Transaction = require('../../models/Transaction');
const User = require('../../models/User');
const _ = require('lodash');

exports.loadList = async (req, res) => {
	let limit = req.query.limit && req.query.limit <= 100 ? parseInt(req.query.limit) : 20;
	let page = 1;
	if (req.query) {
		if (req.query.page) {
		  	req.query.page = parseInt(req.query.page);
		  	page = Number.isInteger(req.query.page) ? req.query.page : 1;
		}
	}
	let _where_obj = {};
	let total = await Transaction.count({where: _where_obj});
	const transactions_data = await Transaction.findAll( { where: _where_obj, offset:((page-1)*limit), limit : limit, order: [['id', 'desc']]});
	let transactions = [];

	if(transactions_data !== null){
		await Promise.all(transactions_data.map(async transaction => {
			const user = await transaction.user();
			let tmp_transaction = transaction.dataValues;
			tmp_transaction.id = parseInt(transaction.id);
			tmp_transaction.wallet_address = user.wallet_address;
			transactions.push(tmp_transaction);
		}));
	}

	// Resort
	transactions = _.orderBy(transactions, ['id'], ['desc']);

	res.json({ 
		success: true,
		transactions: transactions,
		total: total,
		page: page,
		limit: limit
	});
}