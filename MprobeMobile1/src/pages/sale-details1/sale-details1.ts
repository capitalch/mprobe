import {Component} from '@angular/core';
import * as moment from 'moment';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';
import {SaleDetails2Page} from '../sale-details2/sale-details2';
@IonicPage()
@Component({selector: 'page-sale-details1', templateUrl: 'sale-details1.html'})
export class SaleDetails1Page {
  subscriptions : any;
  saleDetails1 : any = [];
  totals : any = {};
  constructor(public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad SaleDetails1Page');
    this.subscriptions = this
      .appService
      .filterOn('tunnel:get:sale:details1')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            this.saleDetails1 = d.data;
            this.totals = this
              .saleDetails1
              .reduce((prev, current) => {
                prev.total_amt = Number(current.total_amt) + prev.total_amt;
                prev.gp = Number(current.gp) + prev.gp;
                prev.cgp = Number(current.cgp) + prev.cgp;
                return (prev);
              }, {
                total_amt: 0,
                gp: 0,
                cgp: 0
              });
          })();
      });
  }

  ionViewDidEnter() {
    let master_id = this
      .navParams
      .get('id');
    let dateString = this
      .navParams
      .get('dateString');
    let mdate = moment(dateString, 'DD/MM/YYYY').format('YYYY-MM-DD');
    this
      .appService
      .httpPost('tunnel:get:sale:details1', {
        args: {
          mdate: mdate,
          master_id: master_id
        }
      })
  }

  saleDetails2(item) {
    let bill_memo_id = item.bill_memo_id;
    this
      .navCtrl
      .push(SaleDetails2Page, {bill_memo_id: bill_memo_id});
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }

}
