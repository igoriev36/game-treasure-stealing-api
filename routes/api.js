const AppController = require('../app/controllers/AppController');
const AuthController = require('../app/controllers/AuthController');
const UserController = require('../app/controllers/UserController');
const {authenticateToken} = require('../app/middlewares/auth.middleware');

exports.config = function(app, _prefix){
  if(typeof _prefix === 'undefined'){
    _prefix = '/api/v1'
  }

  //Auth
	app.post(`${_prefix}/auth/login`, [AuthController.login]);
	app.post(`${_prefix}/auth/refresh-token`, [AuthController.refresh_token]);
	app.get(`${_prefix}/auth/info`, [authenticateToken, AuthController.info]);
	app.post(`${_prefix}/auth/logout`, [authenticateToken, AuthController.logout]);

	// Update user
	app.get(`${_prefix}/game/info`, [authenticateToken, AppController.getGameInfo]);
	app.post(`${_prefix}/user/update-hero-status`, [authenticateToken, UserController.updateHeroStatus]);
	app.post(`${_prefix}/user/update-non-nft-entries`, [authenticateToken, UserController.updateNonNftEntries]);
	app.post(`${_prefix}/user/enter-game`, [authenticateToken, UserController.enterGame]);
}