import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams, AlertController} from 'ionic-angular';
import {Subscription} from 'rxjs/Subscription';
import {BusinessPage} from '../business/business';
import {AccountsPage} from '../accounts/accounts';
import {AppServiceProvider} from '../../providers/app-service/app-service';
// import * as _ from 'lodash';

@IonicPage()
@Component({selector: 'page-home', templateUrl: 'home.html'})
export class HomePage {
  subscriptions : Subscription;
  connectedUsers : any = [];
  constructor(public alertCtrl : AlertController, public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {
  }
  
  ionViewDidEnter() {
    // console.log('ionViewDidEnter HomePage');
    // let soc = this
    //   .appService
    //   .get('socket');
    // soc && (!_.isEmpty(soc)) && this
    //   .appService
    //   .httpPost('get:connected:users');
  }

  showConnectedUsers() {
    let alert = this
      .alertCtrl
      .create({title: 'Connected users', subTitle: 'All connected users', buttons: ['OK']});
    this
      .connectedUsers
      .forEach(element => {
        alert.addInput({type: 'radio', label: element, value: element, checked: true});
      });

    alert.present();
  }

  ionViewDidLoad() {
    // console.log('Subscribed in HomePage');
    // console.log('ionViewDidLoad HomePage');
    this.subscriptions = this
      .appService
      .filterOn('get:connected:users')
      .subscribe(d => {
        (d.error && (console.log(d.error) || true)) || ((() => {
          this.connectedUsers = d.data;
        })());
      });
  }
  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
    console.log('Unsubscribed in HomePage');
  }
  doAccounts() {
    this
      .navCtrl
      .push(AccountsPage);
  }

  doBusiness() {
    this
      .navCtrl
      .push(BusinessPage);
  }
}
