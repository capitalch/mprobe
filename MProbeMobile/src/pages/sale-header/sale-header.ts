import {Component} from '@angular/core';
import * as moment from 'moment';
import {Platform} from 'ionic-angular';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';
import {DatePicker} from '@ionic-native/date-picker';
import {SaleDetails1Page} from '../sale-details1/sale-details1';
import {SaleDetailsProductPage} from '../sale-details-product/sale-details-product';
// import {getToUid, getSelectedDatabaseName} from '../../app/utility';

@IonicPage()
@Component({selector: 'page-sale-header', templateUrl: 'sale-header.html'})
export class SaleHeaderPage {
  subscriptions : any;
  saleHeaders : [any];
  saleTotals : any = {};
  currentDateString : string = '';
  constructor(public platform : Platform, public datePicker : DatePicker, public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad SaleHeaderPage');
    this.currentDateString = moment(this.appService.getTodaysDateAsString()).format('DD/MM/YYYY');
    this.subscriptions = this
      .appService
      .filterOn('tunnel:get:todays:sale')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            this.saleHeaders = d.data;
            this.saleTotals = this
              .saleHeaders
              .reduce((prev, current) => {
                prev.sale =  prev.sale + Number(current.sale);
                prev.gp =  prev.gp + Number(current.gp);
                prev.cgp = prev.cgp + Number(current.cgp);
                return (prev);
              }, {
                sale: 0.00,
                gp: 0.00,
                cgp: 0.00
              });
            console.log(d.data)
          })();
      });
    let subA = this
      .appService
      .filterOn('local:refresh:screen')
      .subscribe(d => {
        this.showSale();
      });
    this
      .subscriptions
      .add(subA);
  }

  ionViewDidEnter() {
    this.showSale();
  }

  showSale() {
    let mdate = moment(this.currentDateString, 'DD/MM/YYYY').format('YYYY-MM-DD');

    // let toUid = getToUid(this.appService.get('selectedDatabase'));
    this
      .appService
      .httpPost('tunnel:get:todays:sale', {
        args: {
          mdate: mdate
        }
      });
  }

  nextDate() {
    let a = moment(this.currentDateString, 'DD/MM/YYYY');
    let b = a.add(1, 'd');
    let c = moment(b).format('DD/MM/YYYY');
    this.currentDateString = c;
    this.showSale();
  }

  prevDate() {
    let a = moment(this.currentDateString, 'DD/MM/YYYY');
    let b = a.add(-1, 'd');
    let c = moment(b).format('DD/MM/YYYY');
    this.currentDateString = c;
    this.showSale();
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }

  saleOnDate() {
    let mdate = moment(this.currentDateString, 'DD/MM/YYYY').toDate();
    this
      .platform
      .is('cordova')
      ? this
        .datePicker
        .show({date: mdate, mode: 'date', androidTheme: this.datePicker.ANDROID_THEMES.THEME_HOLO_DARK})
        .then(date => {
          this.currentDateString = moment(date).format('DD/MM/YYYY');
          this.showSale();
        }, err => console.log('Error occurred while getting date: ', err))
      : alert('Date picker is only available on mobile platforms');
  }

  saleDetails(header) {
    this
      .navCtrl
      .push(SaleDetails1Page, {
        id: header.id,
        pos_name: header.pos_name,
        dateString: this.currentDateString
      });
    // console.log(header);
  }

  saleDetailsProduct() {
    this
      .navCtrl
      .push(SaleDetailsProductPage, {currentDateString: this.currentDateString});
  }
}
