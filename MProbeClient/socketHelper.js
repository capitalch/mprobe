let util = require('util');
let fs = require('fs');
let ss = require('socket.io-stream');
let request = require('request');
let logger = require('./logger');
let config = require('./config');
let def = require('./definitions');
let messages = require('./messages');
let eventHelper = require('./eventHelper');
let sqlAny = require('./sqlAny');
// When server disconnects then re connection does not take place. Otherwise
// socket is reconnected automatically

let clientInfo = config.clientInfo;
let socket = {};
let socketHelper = {};

socketHelper.init = () => {
    socket = require('socket.io-client')(config.host, {
        query: util.format("token=%s&clientInfo=%s", socketHelper.token, JSON.stringify(config.clientInfo)),
        reconnection: true,
        reconnectionDelay: 5000,
        reconnectionDelayMax: 10000
        // ,reconnectionAttemptsMax:2 //not working
    });
    socket.on('connect', function () {
        // logger.info(config.messages['connected:link:server']);
        console.log(config.messages['connected:link:server'])
        // eventHelper.emit('validate:user', true);
    });

    socket.on('sc-error', function (data) {
        console.log(data);
    });

    socket.on('disconnect', function (data) {
        // logger.info(config.messages['disconnected:link:server']);
        console.log(data);
        if (data == 'io server disconnect') {
            eventHelper.emit('shut:down:server');
        }
    });
    /*
options:{type:'web/sql', url:'http://www.google.com',method:'GET',json:false}}
*/
    ss(socket).on('sc-msg', (options, fn) => {
        let stream = ss.createStream();
        try {
            if (options && options.type) {
                if (options.type == 'web') {
                    request(options).pipe(stream);
                    fn({isWebRes: true, stream: stream});
                } else if (options.type = 'sql') {
                    console.log('Tenant server executing request');
                    sqlAny.executeSql(options, fn);
                }
            }
        } catch (error) {
            socket.emit('error', error);
        }
    });

    socket.on('cc-msg', function (data, fn) {
        messageHelper(data, fn);
    });
}

module.exports = socketHelper;
/*
1. Signature of socket.emit is  socket.emit('cc-msg',someData,function(data){}). The third argument is a callback function
which has only one argument say data. This data will contain the results transferred from the destination of socket.

2. signature of data.innerData is data.innerData->action:'query',database:'',sqlKey:'',args:''
*/