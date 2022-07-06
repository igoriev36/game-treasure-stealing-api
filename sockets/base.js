var url = require('url');
var events = require('events');
var ev = new events.EventEmitter();

var gts_socket = (io) => {
	//For dashboard
	io.of('gts.dashboard').on('connection', (socket) => {
		socket.emit('gts_connect', { message: 'Game connected' });
	})
}

module.exports = gts_socket;