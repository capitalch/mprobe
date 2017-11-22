let logger = require('./logger');
let http = require('http');
let config = require('./config');
let eventHelper = require('./eventHelper');
let httpRequest = require('./httpRequest');
// logger.info(config.messages['server:starting']);
console.log(config.messages['server:starting']);
let port = config.port;

let server = http.createServer();
server.listen(port, function () {
    // logger.info(config.messages['terminal:listening:port'], port);
    console.log(config.messages['terminal:listening:port'], port);
});
eventHelper.on('shut:down:server',()=>{
    console.log(config.messages['shutting:down:server']);
    server.close();
    console.log(config.messages['shut:down:server']);
})
httpRequest.init();
