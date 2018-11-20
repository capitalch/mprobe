"use strict";
let fs = require('fs');
let http = require('http');
let bodyParser = require('body-parser');
// let config = JSON.parse(fs.readFileSync('config.json', 'utf8'));
let config = require('./config.json');
let def = require('./artifacts/definitions');
let messages = require('./artifacts/messages');
let socketHelper = require('./artifacts/socketHelper');
let router = require('./artifacts/router');

let express = require('express');
let app = express();
// app.use(router);
let server = http.createServer(app);
server.listen(config.port, function () {
    console.log("Server listening on: %s:%s", config.host, config.port);
    socketHelper.init(server);
});

process.env.NODE_ENV = config.env;
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(bodyParser.json({ type: 'application/vnd.api+json' }));
//for cross domain
let allowCrossDomain = function (req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
    res.header('Access-Control-Allow-Credentials', 'true');
    res.header('Access-Control-Allow-Headers', 'Origin, Accept, Content-Type, Authorization, Content-Length, X-Requested-With, A' +
        'ccess-Control-Allow-Origin,x-access-token');
    // intercept OPTIONS method
    if ('OPTIONS' == req.method) {
        res.send(200);
    } else {
        next();
    }
};
app.use(allowCrossDomain);

app.post('/test/timer', (req, res) => {
    setTimeout(() => res.status(200).json({ status: 'success' }), 10000);
})

app.use(router);
app.get('/*', function (req, res) {
    res
        .status(200)
        .end('ok');
});

app.use(function (err, req, res, next) {
    if (err) {
        if (err.hasOwnProperty('body')) {
            var error = new def.NError(err.status, err.message, err.body);
            err = error;
        }
    } else {
        err = new def.NError(404, messages.errUrlNotFound, messages.messUrlNotFoundDetails);
    }
    next(err);
});

//development error handler
if (process.env.NODE_ENV === 'development') {
    app
        .use(function (err, req, res, next) {
            console.log(messages.errDevError);
            if (!res.finished) {
                res.status(err.status || 500);
                res.json({ error: err });
            }
        });
}
//production error handler
app
    .use(function (err, req, res, next) {
        console.log(messages.errProdError);
        if (!res.finished) {
            res.status(err.status || 500);
            res.json({ error: err });
        }
    });
