var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var bodyParser = require('body-parser');

var app = express();
var cron = require('node-cron');

var GameHelper = require('./app/GameHelper');
var { Solana } = require('./app/solana');

app.use(function (req, res, next) {
  const origin = process.env.ORIGIN_ALLOW || '';
  res.header('Access-Control-Allow-Origin', origin);
  res.header('Access-Control-Allow-Credentials', 'true');
  res.header('Access-Control-Allow-Methods', 'GET,HEAD,PUT,PATCH,POST,DELETE');
  res.header('Access-Control-Expose-Headers', 'Content-Length');
  res.header('Access-Control-Allow-Headers', 'Accept, Authorization, Content-Type, X-Requested-With, Range, x-api-key, x-app-id, x-build-id, x-viewer-address');
  if (req.method === 'OPTIONS') {
    return res.sendStatus(200);
  } else {
    return next();
  }
});

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json({limit: '50mb'}));
app.use(express.urlencoded({ extended: false }));
app.use(bodyParser.urlencoded({ extended: true, limit: '50mb' }));
app.use(cookieParser());
app.use('/admin', express.static(path.join(__dirname, 'admin')));
app.use(express.static(path.join(__dirname, 'public')));

const AdminApiRouter = require('./routes/admin-api');
const ApiRouter = require('./routes/api');
const WebRouter = require('./routes/web');
AdminApiRouter.config(app);
WebRouter.config(app);
ApiRouter.config(app);

// For Cronjob
cron.schedule('* * * * *', async () => {
  //app.io.of('gts.dashboard').emit('game_update', { msg: 'running a task every minute' });
  const Sol = new Solana();
  await Sol.updateSolRate();
});

cron.schedule('0 7,19 * * *', async () => {
  //const Sol = new Solana();
  //await Sol.updateSolRate();
});

cron.schedule('0 17 * * *', async () => {
  app.io.of('gts.dashboard').emit('game_update', { msg: 'Running a job at 17:00 at UTC timezone' });
  const game_helper = new GameHelper();
  await game_helper.PrizesDistribution();
}, {
  scheduled: true,
  timezone: "UTC"
});

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
