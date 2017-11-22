import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';

@IonicPage()
@Component({selector: 'page-cash-payments', templateUrl: 'cash-payments.html'})
export class CashPaymentsPage {
  subscriptions : any;
  payments : any = [];
  constructor(public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad CashPaymentsPage');
    this.subscriptions = this
      .appService
      .filterOn('tunnel:get:cash:payments')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            this.payments = d.data;
          })();
      });
    let subA = this
      .appService
      .filterOn('local:refresh:screen')
      .subscribe(d => {
        this.getCashPayments();
      });
    this
      .subscriptions
      .add(subA);
  }

  getCashPayments() {
    this
      .appService
      .httpPost('tunnel:get:cash:payments')
  }

  ionViewDidEnter() {
    this.getCashPayments();
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }

}
