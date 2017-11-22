import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {SaleHeaderPage} from '../sale-header/sale-header';
import {HealthPage} from '../health/health';
import {JakarPage} from '../jakar/jakar';
import {OrdersPage} from '../orders/orders';

@IonicPage()
@Component({selector: 'page-business', templateUrl: 'business.html'})
export class BusinessPage {
  constructor(public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad BusinessPage');    
  }

  getSaleHeader() {
    this
      .navCtrl
      .push(SaleHeaderPage);
  }

  getHealth() {
    this.navCtrl.push(HealthPage);
  }

  getJakar(){
    this.navCtrl.push(JakarPage);
  }

  placeOrders(){
    this.navCtrl.push(OrdersPage)
  }

}
