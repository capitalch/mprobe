import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';

@IonicPage()
@Component({selector: 'page-health', templateUrl: 'health.html'})
export class HealthPage {
  subscriptions : any;
  health : any = {};
  constructor(public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    // console.log('ionViewDidLoad HealthPage');
    this.subscriptions = this
      .appService
      .filterOn('tunnel:get:business:health')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            this.health = d.data[0];
            console.log(d.data)
          })();
      });
    let subA = this
      .appService
      .filterOn('local:refresh:screen')
      .subscribe(d => {
        this.showHealth();
      });
    this
      .subscriptions
      .add(subA);
  }

  ionViewDidEnter() {
    this.showHealth();
  }

  showHealth() {
    this
      .appService.httpPost('tunnel:get:business:health');
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }

}
