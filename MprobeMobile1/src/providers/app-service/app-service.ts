import {Injectable} from '@angular/core';
import {Http} from '@angular/http';
import {AlertController, ModalController, Platform} from 'ionic-angular';
// import * as Mustache from 'mustache'; import * as io from 'socket.io-client';
import * as _ from 'lodash';
import * as moment from 'moment';
import {Storage} from '@ionic/storage';
import 'rxjs/add/operator/map';
import {Subject} from 'rxjs/Subject';
import {Subscription} from 'rxjs/Subscription';
import {Observable} from 'rxjs/observable';
import 'rxjs/add/operator/filter';
import {SelectDatabasePage} from '../../pages/select-database/select-database';

import {config, messages, urlMappings} from '../../app/app.config';

declare var navigator : any;
declare var Connection : any;
@Injectable()
export class AppServiceProvider {
  global : any = {};
  subject : Subject < any >;
  subscriptions : Subscription;

  constructor(public modalCtrl : ModalController, public platform : Platform, private storage : Storage, public alertCtrl : AlertController, public http : Http) {
    this.subject = new Subject();
    this.init();
  };

  init() {
    this
      .getFromStorage('uid')
      .then(uid => {
        this.set('uid', uid);
      });
    this
      .getFromStorage('selectedDatabase')
      .then(db => {
        db
          ? this.set('selectedDatabase', db)
          : this.showAlert('Notice', messages.selectDatabase);
      });

    this
      .getFromStorage('userCode')
      .then(userCode => {
        userCode
          ? this.set('userCode', userCode)
          : this.set('userCode', 1);
      });
    this
      .getFromStorage('token')
      .then(token => {
        token && this.set('token', token);
      });
    this.initSubscriptions();
  }

  initSubscriptions() {
    this.subscriptions = this
      .filterOn('post:retrieve:info')
      .subscribe(d => {
        d.error
          ? alert(d.error)
          : (() => {
            console.log(d.data);
            let tenant = this.get('uid') && this
              .get('uid')
              .split('.')[0];
            let clientInfoList = d
              .data
              .filter((x) => x.uid.split('.')[0] == tenant)
            let filteredList = clientInfoList.map((x) => {
              return ({databases: x.databases, users: x.users, uid: x.uid});
            });
            let finalDatabases = filteredList.reduce((prev, x) => {
              let databases = x.databases;
              let toUid = x.uid;
              let users = x.users;
              let me = users.find(y => y.uid == this.get('uid'));
              let myUserCode : string = me && me.usercode;
              let ret;
              let allowedDatabases = me && _.flatMap(me.databases, y => y); //ternary if..else
              ret = allowedDatabases && allowedDatabases[0] && (allowedDatabases[0] == '*')
                ? databases
                : allowedDatabases || [];
              ret = ret.map(z => myUserCode.toString().concat(':').concat(toUid).concat(':').concat(z));
              prev = prev.concat(ret);
              return (prev);
            }, []);
            let modal = this
              .modalCtrl
              .create(SelectDatabasePage, {databases: finalDatabases});
            modal.onDidDismiss(d => {
              let selectedDatabase = this.get('selectedDatabase');
              this.set('selectedDatabase', d.database || selectedDatabase);
              this.set('userCode', d.userCode);
              this.setInStorage('selectedDatabase', d.database || selectedDatabase);
              this.setInStorage('userCode', d.userCode);
              d.database && this.emit('local:refresh:screen');
            });
            modal.present();
          })();
      });
  }

  showControl(controlCode) {
    const userCode = this.get('userCode');
    let ret = userCode % controlCode;
    return (ret === 0);
  }

  checkNetwork() {
    this
      .platform
      .ready()
      .then(() => {
        if (this.platform.is('cordova')) {
          let networkState = navigator.connection.type;
          if (networkState == Connection.NONE) {
            this.showAlert('Connection', messages.noInternet);
          }
        }
      });
  }

  logout() {
    this
      .storage
      .clear();
  }

  showAlert(title, subTitle) {
    let alert = this
      .alertCtrl
      .create({title: title, subTitle: subTitle, buttons: ['OK']});
    alert.present();
  }

  getFromStorage(key) {
    return (this.storage.get(key)); //This is a promise
  };
  setInStorage(key, value) {
    this
      .storage
      .set(key, value);
  }

  get(key : string) {
    return (this.global[key]);
  };

  set(key : string, value : any) {
    this.global[key] = value;
  };

  remove(key) {
    delete this.global[key];
  };

  getToUid() {
    let selectedDatabase = this.get('selectedDatabase');
    let temp = selectedDatabase && selectedDatabase.split(':');
    let temp1 = temp && temp.length == 2;
    let ret = temp1 && temp[0];
    return (ret);
  };

  getSelectedDatabaseName() {
    let selectedDatabase = this.get('selectedDatabase');
    let temp = selectedDatabase && selectedDatabase.split(':');
    let temp1 = temp && temp.length == 2;
    let ret = temp1 && temp[1];
    return (ret);
  }

  httpPost(id : string, body?: any, otherInfo?: any) {
    let toUid = this.getToUid();
    let dbName = this.getSelectedDatabaseName();
    let mapping = urlMappings[id] || urlMappings['generic'];
    let url = config
      .host
      .concat(mapping);
    body || (body = {});
    this.get('token') && (body.token = this.get('token'));
    Object.assign(body, {
      type: 'sql',
      sqlKey: id,
      dbName: dbName,
      toUid: toUid,
      args: body.args || {}
    });
    // body.args||(body.args={});
    this
      .http
      .post(url, body)
      .map(response => response.json())
      .subscribe(d => {
        this
          .subject
          .next({id: id, data: d, body: body, otherInfo: otherInfo});
      }, err => {
        this
          .subject
          .next({id: id, error: err});
      });
  };

  httpGet(id : string, body?: any) {
    // var url = urlHash[id];
    if (body) {
      if (body.queryParms) {
        // url = mustache.render(url, body.queryParms);
      }
    }
  };

  emit(id : string, options?: any) {
    this
      .subject
      .next({id: id, data: options});
  };

  filterOn(id : string) : Observable < any > {
    return(this.subject.filter(d => (d.id === id)));
  };

  getTodaysDateAsString() {
    return (moment().format('YYYY-MM-DD'));
  }
}

/* deprecated
disconnectSocket() {
    let soc = this.get('socket');
    if (soc) {
      if (!_.isEmpty(soc)) {
        soc.disconnect();
      }
    }
    //soc && (!_.isEmpty(soc)) && (soc.disconnect());
    this.set('socket', {});
  }

  connectSocket(uid) {
    if (uid) {
      this.set('uid', uid);
    } else {
      this.showAlert('Error', errorMessages['loginRequired']);
      return;
    }

    let soc = this.get('socket');

    if (soc && (!soc.connected)) {
      if(!_.isEmpty(soc)){
        soc.disconnect();
        soc={};
      }
      // let client = {
      //   uid: uid,
      //   clientInfo: encodeURIComponent(JSON.stringify(config.clientInfo)),
      //   terminalId: this.get('terminalId')
      // };
      // var socket = io({transports: ['websocket']});
      // soc = io(config.socketHost, {
      //   query: Mustache.render('uid={{uid}}&clientInfo={{clientInfo}}&terminalId={{terminalId}}', client)
      //   // ,transports: ['websocket']
      // });

      soc.on('allUsers', (d) => {
        this.set('allUsers', d.count);
      });

      soc.on('connect', () => {
        this.set('socket', soc);
        //to show connected users in home page
        this.socketEmit('cs-msg', 'get:connected:users');
      });
    }
  };

  //innerData.action works as id
  socketEmit(msg : string, id, innerData
    ?) {
    let soc = this.get('socket');
    if ((!soc) || _.isEmpty(soc)) {
      this.showAlert('Error', errorMessages['connectionFailure']);
      return;
    }
    innerData
      ? innerData.action = id
      : innerData = {
        action: id
      };

    let selectedDatabase = this.get('selectedDatabase');
    if (innerData.isSql && ((!selectedDatabase) || selectedDatabase == 'Database')) {
      this.showAlert('Notice', messages.selectDatabase);
      return;
    }

    innerData.database = selectedDatabase.split('.')[1];
    let toUid = this
      .get('tenant')
      .concat(':')
      .concat(selectedDatabase.split('.')[0]);
    // this
    //   .get('socket')
    //   .emit(msg, {
    //     uid: config.uid,
    //     innerData: innerData,
    //     toUid: toUid
    //   }, data => {
    //     if (data.error) {
    //       // console.log(data.error);
    //       this
    //         .subject
    //         .next({id: innerData.action, error: data.error});
    //     } else {
    //       this
    //         .subject
    //         .next({id: innerData.action, data});
    //     }
    //   })
  };

  socketFilterOn(id : string) : Observable < any > {
    return(this.subject.filter(d => d.id === id));
  };
*/
