// "use strict";
let http = require('http');
let logger = require('./logger');
let request = require('request');
let config = require('./config');
let crypto = require('crypto');

let eventHelper = require('./eventHelper');
let httpRequest = {};
let socketHelper = require('./socketHelper');

let encrypt = () => {
    let hash = crypto.createHash('sha256');
    let uid = config.uid;
    let uidPwd = uid.concat(':', config.pwd);
    let uidPwdUpdate = hash.update(uidPwd, 'utf-8');
    let uidPwdHash = uidPwdUpdate.digest('hex');
    let encrypted = new Buffer(uid.concat(':', uidPwdHash)).toString('base64');
    return (encrypted);
}

let options = {
    url: config
        .host
        .concat('/api/validate/user'),
    method: 'POST',
    body: {
        auth: encrypt()
    },
    json: true
};

let callback = (error, response, body) => {
    if(body && body.isValid){
        socketHelper.token=body.token;
    } else if(body && (body.isValid==false)){
        console.log(config.messages['validation:failed']);
        //close down the server
        eventHelper.emit('shut:down:server');
    } else {
        console.log(config.messages['unknown:server:error']);
    }
    socketHelper.init();    
};

httpRequest.init = ()=> request(options, callback);
module.exports = httpRequest;