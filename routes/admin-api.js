const AdminAuthController = require('../app/controllers/admin/AdminAuthController');
const AdminGameController = require('../app/controllers/admin/AdminGameController');
const SettingsController = require('../app/controllers/admin/SettingsController');
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

	// Game
	app.get(`${_prefix}/game/history-list`, [authenticateToken, AdminGameController.loadGameHistory]);
}