//const Tools = require('../app/Tools'); 
const AppController = require('../app/controllers/AppController');

exports.config = function(app, _prefix){
  if(typeof _prefix === 'undefined'){
    _prefix = ''
  }

  app.get('/', function(req, res, next) {
	  res.render('index', { title: 'Game' });
	});

  app.get('/dev', [AppController.dev]);
}