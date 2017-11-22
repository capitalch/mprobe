import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import * as moment from 'moment';
import {AppServiceProvider} from '../../providers/app-service/app-service';

@IonicPage()
@Component({selector: 'page-sale-details-product', templateUrl: 'sale-details-product.html'})
export class SaleDetailsProductPage {
  subscriptions : any;
  saleDetails : any = [];
  totals : any = [];
  constructor(public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad SaleDetailsProductPage');
    this.subscriptions = this
      .appService
      .filterOn('tunnel:get:sale:details:product')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            console.log(d.data);
            this.saleDetails = d
              .data
              .sort((x, y) => y.days - x.days);

            this.totals = this
              .saleDetails
              .reduce((prev, current) => {
                prev.value = Number(current.value) + prev.value;
                prev.gp = Number(current.gp) + prev.gp;
                prev.cgp = Number(current.cgp) + prev.cgp;
                prev.qty = Number(current.qty) + prev.qty;
                return (prev);
              }, {
                value: 0,
                qty: 0,
                gp: 0,
                cgp: 0
              });

          })();
      });
  }

  ionViewDidEnter() {
    this.showSaleDetailsProduct();
  }

  showSaleDetailsProduct() {
    let mdate = moment(this.navParams.get('currentDateString'), 'DD/MM/YYYY').format('YYYY-MM-DD');
    this
      .appService
      .httpPost('tunnel:get:sale:details:product', {
        args: {
          mdate: mdate
        }
      });
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }

}
