let winston = require('winston');
const tsFormat = () => (new Date()).toLocaleString('en-US', { hour12: false });
let logger = new(winston.Logger)({
    transports: [
        new(winston.transports.Console)({json: false, timestamp: tsFormat}),
        new winston
            .transports
            .File({
                filename: __dirname + '/log/info.log',
                json: false,
                timestamp: tsFormat,
                maxsize:1000000
            })
    ],
    exitOnError: false
});

module.exports = logger;