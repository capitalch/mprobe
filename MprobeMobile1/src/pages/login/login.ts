import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';
import {messages, config} from '../../app/app.config';
import {encryptPwd} from '../../app/utility';
@IonicPage()
@Component({selector: 'page-login', templateUrl: 'login.html'})
export class LoginPage {
  userName : any;
  password : any;
  subscriptions : any;
  constructor(public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {
    this.subscriptions = this
      .appService
      .filterOn('post:validate:user')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            if (d.data.isValid) {
              this
                .appService
                .setInStorage('token', d.data.token);
              this.appService.set('token',d.data.token);
              //d.otherInfo is user name
              let uid = config
                .tenant
                .concat('.',config.office,'.',d.otherInfo);               
              uid && ((appService.setInStorage('uid', uid)) || appService.set('uid', uid));
              this
                .navCtrl
                .pop();
            } else {
              this.userName = '';
              this.password = '';
              alert(messages.messInvalidLogin);
            }
          })();
      });
  }
  login() {
    let auth = encryptPwd(this.userName, this.password);
    this
      .appService
      .httpPost('post:validate:user', {
        auth: auth
      }, this.userName);
  };

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }
}
