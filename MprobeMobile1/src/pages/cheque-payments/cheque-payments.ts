import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';
@IonicPage()
@Component({selector: 'page-cheque-payments', templateUrl: 'cheque-payments.html'})
export class ChequePaymentsPage {
  subscriptions : any;
  payments : any = [];
  constructor(public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad ChequePaymentsPage');
    this.subscriptions = this
      .appService
      .filterOn('tunnel:get:cheque:payments')
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
        this.getChequePayments();
      });
    this
      .subscriptions
      .add(subA);
  }

  getChequePayments() {
    this
      .appService
      .httpPost('tunnel:get:cheque:payments')
  }

  ionViewDidEnter() {
    this.getChequePayments();
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }
}
