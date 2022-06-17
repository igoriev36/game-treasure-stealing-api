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
	app.post(`${_prefix}/user/update-hero-status`, [authenticateToken, UserController.updateHeroStatus]);
}