import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';
import {Platform} from 'ionic-angular';
import {JakarDetailsPage} from '../jakar-details/jakar-details';

@IonicPage()
@Component({selector: 'page-jakar', templateUrl: 'jakar.html'})
export class JakarPage {
  jakarDays : string = '360';
  subscriptions : any;
  items : any = [];
  totals : any = [];
  constructor(public platform : Platform, public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad JakarPage');
    this.subscriptions = this
      .appService
      .filterOn('tunnel:get:jakar:on:days')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            this.items = d
              .data
              .map(x => {
                x.total_value = x.total_value || 0;
                x.jakar_value = x.jakar_value || 0;
                x.percent = x.percent || 0;
                return (x);
              });
            this.totals = this
              .items
              .reduce((prev, current) => {
                prev.jakar_value = Number(current.jakar_value) + prev.jakar_value;
                prev.total_value = Number(current.total_value) + prev.total_value;
                return (prev);
              }, {
                total_value: 0,
                jakar_value: 0,
                percent: 0
              });
            this.totals.percent = (this.totals.jakar_value / this.totals.total_value) * 100;
          })();
      });
       let subA = this
      .appService
      .filterOn('local:refresh:screen')
      .subscribe(d => {
        this.getJakar();
      });
    this
      .subscriptions
      .add(subA);
  }

  ionViewDidEnter() {
    this.getJakar();
  }

  jakar(days) {
    console.log(days);
    this.jakarDays = days;
    this.getJakar();
  }

  getJakar() {
    this
      .appService
      .httpPost('tunnel:get:jakar:on:days', {        
        args: {
          mdays: this.jakarDays
        }
      });
  }

  selectJakarDays() {
    this
      .platform
      .is('cordova') && (() => {
      let ageingDays = [
        {
          value: '90'
        }, {
          value: '180'
        }, {
          value: '270'
        }, {
          value: '360'
        }
      ];
      let config = {
        title: "Select stock ageing days",
        items: [
          [ageingDays]
        ],
        defaultItems: [
          ['360']
        ],
        wrapWheelText: true,
        positiveButtonText: "Done",
        negativeButtonText: "Cancel",
        displayKey: "value"
      };
        ( <any>window) .SelectorCordovaPlugin .showSelector(config, (result)=>{
      this.jakarDays=result[0].value;   
      this.getJakar(); });
    })();
  }

  jakarDetails(item) {
    this.navCtrl.push(JakarDetailsPage,{counter_code:item.counter_code,jakarDays:this.jakarDays});  
    console.log(item);
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }
}