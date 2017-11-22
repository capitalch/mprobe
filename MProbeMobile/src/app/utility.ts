import * as CryptoJS from 'crypto-js';
import {config} from './app.config';
let encryptPwd = (userName,pwd) => {
    let uid = config.tenant.concat('.').concat(config.office).concat('.').concat(userName);
    let uidPwd = uid.concat(':', pwd);
    let hash = CryptoJS.SHA256(uidPwd);
    let encrypted = btoa(uid.concat(':', hash));    
    console.log(encrypted);
    return (encrypted);
};
export {encryptPwd};