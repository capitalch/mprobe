let logger = require('./logger');
let config = require('./config');
let edgeConnector = require('./edgeConnector');
let sql = require('./sql');

let message = {
    'query:sql': querySql,
    'get:databases': getDatabases
};

function querySql(data, fn) {
    let ret = {};
    let error;
    if (data.innerData.isSql) {
        let sqlString = data.innerData.sqlString;
        (!sqlString) && ((error = 'Sql string error') && logger.error(error));
    } else {
        error = 'Action is not marked as SQL action';
    }
    if (error) {
        ret.error = error;
        fn(ret);
    } else {
        edgeConnector(data.innerData, function (error, result) {
            if (error) {
                ret.error = error.message;
                console.log(error);
            } else {
                if (result) {
                    if (result.error) {
                        ret.error = result.error;
                        console.log(result.error);
                    } else {
                        ret = JSON.parse(result);
                    }
                }
            }
            fn(ret);
        });
    }
};

function getDatabases(data, fn) {
    fn(config.clientInfo.databases);
};

function decodeMessage(data, fn) {
    try {
        data.innerData.isSql && ((data.innerData.sqlString = sql[data.innerData.action]) && (data.innerData.action = 'query:sql'));
        // data.innerData.sqlKey && (data.innerData.action = 'query:sql');
        (!data.innerData.args) && (data.innerData.args = {});
        message[data.innerData.action](data, fn);
    } catch (err) {
        let ret = {};
        ret.error = err.message;
        fn(ret);
    }
}

module.exports = decodeMessage;