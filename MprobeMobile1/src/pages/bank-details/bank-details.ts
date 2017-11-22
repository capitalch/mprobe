import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';

@IonicPage()
@Component({selector: 'page-bank-details', templateUrl: 'bank-details.html'})
export class BankDetailsPage {
  subscriptions : any;
  items : any = [];
  constructor(public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad BankDetailsPage');
    this.subscriptions = this
      .appService
      .filterOn('tunnel:get:bank:recon:details')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            let its = d.data.reverse();
            its.reduce((prev,current)=>{
              current.balance =Number(current.credit_amt) - Number(current.debit_amt) + prev.value;
              prev.value = current.balance;
              return(prev);
            },{value:0});
            this.items=its.reverse();
          })();
      });
  }

  ionViewDidEnter() {
    let accIdBank = this
      .navParams
      .get('accIdBank');
    this
      .appService
      .httpPost('tunnel:get:bank:recon:details', {      
        args: {
          accIdBank: accIdBank
        }
      });
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }

}
