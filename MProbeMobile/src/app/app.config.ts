var config = {
    host: 'http://14.143.150.10:3004',
    tenant: 'capital',
    office: 'mobile'
}
export {config};

let messages = {
    noInternet: 'Internet connection in not found in your device. Connect to internet for this so' +
            'ftware to work',
    selectDatabase: 'Select a database before proceeding',
    messInvalidLogin: 'Invalid login'
};
export {messages};

let errorMessages = {
    loginRequired: 'Login is required',
    connectionFailure: 'Connection to the server is not established. Try to reconnect otherwise check th' +
            'e internet connection'
};
export {errorMessages};

let urlMappings = {
    'post:validate:user': '/api/validate/user'
    ,'post:retrieve:info':'/api/info'
    ,'generic':'/api/tunnel'
    // ,'tunnel:get:todays:sale':'/api/tunnel'
};
export {urlMappings};
// function guid() {   function s4() {     return Math.floor((1 + Math.random())
// * 0x10000)       .toString(16)       .substring(1);   }   return s4() + s4()
// + '-' + s4() + '-' + s4() + '-' +     s4() + '-' + s4() + s4() + s4(); }
// export{guid};