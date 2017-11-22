import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams, AlertController} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';

@IonicPage()
@Component({selector: 'page-place-orders', templateUrl: 'place-orders.html'})
export class PlaceOrdersPage {
  subscriptions : any;
  orders : any = [];
  totals : any = {};
  constructor(public alertCtrl : AlertController, public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    this.subscriptions = this
      .appService
      .filterOn('tunnel:place:order')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            this.orders = d.data;
          })();
      });
  }

  ionViewDidEnter() {
    this
      .appService
      .httpPost('tunnel:place:order', {
        args: {
          item: this
            .navParams
            .get('item'),
          brand: this
            .navParams
            .get('brand'),
          counter: this
            .navParams
            .get('counter')
        }
      });
  }

  copyOrder(order) {
    order.finalOrder = order.order;
  }

  

  setRemarks(order) {
    let prompt = this
      .alertCtrl
      .create({
        title: 'Remarks',
        inputs: [
          {
            name: 'remarks',
            placeholder: 'Remarks',
            value: order.remarks,
            type: 'text'
          }
        ],
        buttons: [
          {
            text: 'Cancel',
            handler: data => {
              console.log('Cancel clicked');
            }
          }, {
            text: 'Save',
            handler: data => {
              order.remarks = data.remarks;
            }
          }
        ]
      });
    prompt.present();
  }

  finalOrder(order) {
    let prompt = this
      .alertCtrl
      .create({
        title: 'Order',
        inputs: [
          {
            name: 'final',
            placeholder: 'Order',
            value: order.finalOrder,
            type: 'number'
          }
        ],
        buttons: [
          {
            text: 'Cancel',
            handler: data => {
              console.log('Cancel clicked');
            }
          }, {
            text: 'Save',
            handler: data => {
              order.finalOrder = data.final;
            }
          }
        ]
      });
    prompt.present();
  }

  addOrder(order) {
    order.finalOrder++;
  }

  minusOrder(order){
  (order.finalOrder==0) || order.finalOrder--; 
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }
}