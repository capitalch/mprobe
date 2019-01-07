let xUrl = {};
xUrl.cloud = 'http://14.143.150.10:3004';
xUrl.cloud = 'http://chisel.cloudjiffy.net'
// xUrl.cloud = 'http://103.217.220.148'
xUrl.local = 'http://localhost:3004';
// xUrl.local = 'http://localhost:3000';
// mpUrl.selected = mpUrl.cloud;
xUrl.selected = xUrl.local;
let config = {
    databaseServerName:'server',
    uid: 'capital.chow.chowServer',
    // uid:'capital.mobile.sushant',
    pwd: '12345',
    uid1: 'capital:capital1',

    port: 3003,
    host: xUrl.selected,
    terminalId: 'NetwovenServer',
    // userCode 0 allows all controls in UI to be displayed. Other user codes might
    // be multiplication of prime numbers. Only controlCode divisible by userCode
    // returning 0 remainder will be visible to the user
    clientInfo: {
        channel: 'track',
        type: 'server',
        databases: ['capi2017'],
        users: [
            {
                uid: 'capital.mobile.sushant',
                databases: ['*'],
                usercode: 0
            }, 
            {
                uid: 'capital.mobile.kamal',
                databases: ['*'],
                usercode: 0
            },
            {
                uid: 'capital.mobile.client1',
                databases: ['*'],
                usercode: 1
            }, {
                uid: 'capital.mobile.client2',
                databases: ['*'],
                usercode: 0
            }, {
                uid: 'capital.mobile.client3',
                databases: ['*'],
                usercode: 0
            }
        ]
    },
    messages: {
        'server:starting': 'Local server is starting...',
        'terminal:listening:port':'This terminal is listening on port: %s',
        'validation:error':'Some error occured during validation process',
        'validation:failed':'Validation failed',
        'net:marshalled:init':'Marshalled .net init',
        'connected:link:server':'Connected to link server',
        'disconnected:link:server':'Link server disconnected',
        'unable:connect':'This terminal is unable to connect to link server',
        'unknown:server:error':'Unknown server error',
        'shutting:down:server':'Shutting down the server...',
        'shut:down:server':'Local server is shut down'
    }
};
module.exports=config;
