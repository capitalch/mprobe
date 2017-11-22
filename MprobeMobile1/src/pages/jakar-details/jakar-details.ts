import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';
@IonicPage()
@Component({selector: 'page-jakar-details', templateUrl: 'jakar-details.html'})
export class JakarDetailsPage {
  products : any = [];
  totals : any = [];
  subscriptions : any;
  constructor(public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad JakarDetailsPage');
    this.subscriptions = this
      .appService
      .filterOn('tunnel:get:jakar:details')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            this.products = d.data;
            this.totals = this
              .products
              .reduce((prev, current) => {
                prev.qty = Number(current.qty) + prev.qty;
                prev.value = Number(current.value) + prev.value;
                return (prev);
              }, {
                qty: 0,
                value: 0
              });
          })();
      });
  }

  ionViewDidEnter() {
    this
      .appService
      .httpPost('tunnel:get:jakar:details', {        
        args: {
          counter_code: this
            .navParams
            .get('counter_code'),
          mdays: this
            .navParams
            .get('jakarDays')
        }
      });
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }

}
