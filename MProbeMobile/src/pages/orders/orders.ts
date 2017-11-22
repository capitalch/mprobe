import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';
import {OrderDetailsPage} from '../order-details/order-details';
@IonicPage()
@Component({selector: 'page-orders', templateUrl: 'orders.html'})
export class OrdersPage {
  subscriptions : any;
  items : any = [];
  totals : any = {};
  constructor(public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad OrdersPage');
    this.subscriptions = this
      .appService
      .filterOn('tunnel:get:orders')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            this.items = d.data;
            this.totals = this
              .items
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
    let subA = this
      .appService
      .filterOn('local:refresh:screen')
      .subscribe(d => {
        this.getOrders();
      });
    this
      .subscriptions
      .add(subA);
  }

  getOrders() {
    this
      .appService
      .httpPost('tunnel:get:orders');
  }

  orderDetails(order) {
    this
      .navCtrl
      .push(OrderDetailsPage, {counter: order.counter});
  }

  ionViewDidEnter() {
    this.getOrders();
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }

}
