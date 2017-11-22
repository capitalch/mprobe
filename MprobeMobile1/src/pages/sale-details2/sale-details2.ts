import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';

@IonicPage()
@Component({selector: 'page-sale-details2', templateUrl: 'sale-details2.html'})
export class SaleDetails2Page {
  subscriptions : any;
  saleDetails2 : any = [];
  constructor(public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad SaleDetails2Page');
    this.subscriptions = this
      .appService
      .filterOn('tunnel:get:sale:details2')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            this.saleDetails2 = d.data;
          })();
      });
  }

  ionViewDidEnter() {
    let bill_memo_id = this
      .navParams
      .get('bill_memo_id');
    this
      .appService
      .httpPost('tunnel:get:sale:details2', {
        args: {
          bill_memo_id: bill_memo_id
        }
      });
    // .socketEmit('cc-msg', 'tunnel:get:sale:details2', {   isSql: true,   args: {
    //    bill_memo_id: bill_memo_id   } });
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }
}
