import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';
import {BankDetailsPage} from '../bank-details/bank-details';

@IonicPage()
@Component({selector: 'page-banks', templateUrl: 'banks.html'})
export class BanksPage {
  subscriptions : any;
  banks : any = [];
  constructor(public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad BanksPage');
    this.subscriptions = this
      .appService
      .filterOn('tunnel:get:banks')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            console.log(d.data);
            this.banks = d.data;
          })();
      });
  }

  getBanks() {
    this
      .appService
      .httpPost('tunnel:get:banks');
  }

  ionViewDidEnter() {
    this.getBanks();
  }

  bankDetails(bank) {
    this.navCtrl.push(BankDetailsPage, {accIdBank:bank.acc_id,accName:bank.acc_name});
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }

}
