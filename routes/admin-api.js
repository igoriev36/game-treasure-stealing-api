const AdminAuthController = require('../app/controllers/admin/AdminAuthController');
const AdminGameController = require('../app/controllers/admin/AdminGameController');
const SettingsController = require('../app/controllers/admin/SettingsController');
const SolanaController = require('../app/controllers/admin/SolanaController');
const {authenticateToken} = require('../app/middlewares/admin-auth.middleware');

exports.config = function(app, _prefix){
  if(typeof _prefix === 'undefined'){
    _prefix = '/api/admin'
  }

  // Auth
	app.post(`${_prefix}/auth/login`, [AdminAuthController.login]);
	app.post(`${_prefix}/auth/refresh-token`, [AdminAuthController.refresh_token]);
	app.get(`${_prefix}/auth/info`, [authenticateToken, AdminAuthController.info]);
	app.post(`${_prefix}/auth/logout`, [authenticateToken, AdminAuthController.logout]);

	// Settings
	app.get(`${_prefix}/load-settings`, [authenticateToken, SettingsController.loadSettings]);
	app.post(`${_prefix}/update-settings`, [authenticateToken, SettingsController.updateSettings]);

	// Solana
	app.get(`${_prefix}/solana/load-wallets`, [authenticateToken, SolanaController.loadWallets]);
	app.get(`${_prefix}/solana/get-balance-wallets`, [authenticateToken, SolanaController.getBalanceWallets]);
	app.post(`${_prefix}/solana/generate-wallet`, [authenticateToken, SolanaController.generateWallet]);
	app.post(`${_prefix}/solana/set-primary-wallet`, [authenticateToken, SolanaController.setPrimaryWallet]);
	app.post(`${_prefix}/solana/update-settings`, [authenticateToken, SolanaController.updateSettings]);
	app.post(`${_prefix}/solana/check-wallet-info`, [authenticateToken, SolanaController.checkWalletInfo]);
	app.post(`${_prefix}/solana/add-wallet`, [authenticateToken, SolanaController.addWallet]);

	// Game
	app.get(`${_prefix}/game/history-list`, [authenticateToken, AdminGameController.loadGameHistory]);
	app.get(`${_prefix}/game-info/:game_id`, [authenticateToken, AdminGameController.loadGameInfo]);
	app.post(`${_prefix}/game/create-game-for-all-user`, [authenticateToken, AdminGameController.createGameForAllUser]);
	app.post(`${_prefix}/game/check`, [authenticateToken, AdminGameController.gameCheck]);
}