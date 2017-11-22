import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';
import {PlaceOrdersPage} from '../place-orders/place-orders';
@IonicPage()
@Component({selector: 'page-order-details', templateUrl: 'order-details.html'})
export class OrderDetailsPage {
  subscriptions : any;
  orders : any = [];
  totals : any = {};
  constructor(public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad OrderDetailsPage');
    this.subscriptions = this
      .appService
      .filterOn('tunnel:get:order:details')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            this.orders = d.data;
            this.totals = this
              .orders
              .reduce((prev, current) => {
                prev.orderQty = Number(current.orderQty) + prev.orderQty;
                prev.value = Number(current.value) + prev.value;
                prev.urgent = Number(current.urgent) + prev.urgent;
                return (prev);
              }, {
                orderQty: 0,
                value: 0,
                urgent: 0
              });
          })();
      });
  }

  ionViewDidEnter() {
    this
      .appService
      .httpPost('tunnel:get:order:details', {
        args: {
          counter: this
            .navParams
            .get('counter')
        }
      });
  }

  placeOrders(order) {
    this
      .navCtrl
      .push(PlaceOrdersPage, {item:order.item,brand:order.brand,counter: order.counter});
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }
}
