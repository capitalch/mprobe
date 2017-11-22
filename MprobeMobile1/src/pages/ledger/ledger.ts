import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';
@IonicPage()
@Component({selector: 'page-ledger', templateUrl: 'ledger.html'})
export class LedgerPage {
  subscriptions : any;
  items : any = [];
  constructor(public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad LedgerPage');
    this.subscriptions = this
      .appService
      .filterOn('tunnel:get:ledger')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            console.log(d.data);
            this.items = d.data;
            let totals = this
              .items
              .reduce((prev, current) => {
                prev.debit = current.debit + prev.debit;
                prev.credit = current.credit + prev.credit;
                return (prev);
              }, {
                debit: 0,
                credit: 0
              });
            let entry:any = {
              ref_no: 'Closing:'
            };
            (totals.debit >= totals.credit)
              ? entry.debit = totals.debit - totals.credit
              : entry.credit = totals.credit - totals.debit;
            this
              .items
              .unshift(entry);
          })();
      });
  }

  ionViewDidEnter() {
    this
      .appService
      .httpPost('tunnel:get:ledger', {
        args: {
          accid: this
            .navParams
            .get('accid')
        }
      });
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }

}
