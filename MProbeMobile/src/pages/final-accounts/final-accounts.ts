import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { AppServiceProvider } from '../../providers/app-service/app-service';
import { LedgerPage } from '../../pages/ledger/ledger';

@IonicPage()
@Component({ selector: 'page-final-accounts', templateUrl: 'final-accounts.html' })
export class FinalAccountsPage {
  subscriptions: any;
  finalAccounts: [any];
  type: string;
  total: number = 0;
  constructor(public appService: AppServiceProvider, public navCtrl: NavController, public navParams: NavParams) {
    // console.log('Parameters:', navParams.get('type'));
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad FinalAccountsPage');
    this.subscriptions = this
      .appService
      .filterOn('tunnel:get:final:accounts')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            console.log(d.data);
            this.finalAccounts = d.data;
            // this.finalAccounts = d.data[0].Table;
            // let profitloss = d.data[1].Table[0].profitloss;
            let plIndex = d.data.findIndex(x => x.bs_id == 9998);
            let pl = d.data[plIndex];
            let profitLoss = +pl.bs_balance;
            d.data.splice(plIndex, 1);

            let totalIndex = d.data.findIndex(x => x.bs_id == 9999);
            let oTotal = d.data[totalIndex];
            let total = +oTotal.bs_balance;
            d.data.splice(totalIndex, 1);
            // let pl = d.data.find((x,i) => x.bs_id == 9998);
            // let profitloss = +pl.bs_balance;
            // let total = +d.data.find(x => x.bs_id == 9999).bs_balance;
            if (profitLoss > 0) {
              if ((this.type == 'L') || (this.type == 'E')) {
                pl.bs_name = 'Profit';
                d.data.push(pl);
                this.total = Math.abs(total) + profitLoss;
              } else {
                this.total = Math.abs(total);
              }
            } else {
              if ((this.type == 'A') || (this.type == 'I')) {
                pl.bs_name = 'Loss';
                d.data.push(pl);
                this.total = Math.abs(Math.abs(total) + profitLoss);
              } else {
                this.total = Math.abs(total);
              }
            }


            // (profitLoss > 0)
            //   ? ((this.type == 'L') || (this.type == 'E')) && (pl.bs_name = 'Profit'
            //     , this.total = Math.abs(total) + profitLoss)
            //   : ((this.type == 'A') || (this.type == 'I')) && (pl.bs_name = 'Loss'
            //     , this.total = Math.abs(total) - profitLoss);
            // (profitloss > 0)
            //   ? ((this.type == 'L') || (this.type == 'E')) && (this.finalAccounts.push({ bs_name: 'Profit', bs_balance: profitloss }))
            //   : ((this.type == 'A') || (this.type == 'I')) && (this.finalAccounts.push({
            //     bs_name: 'Loss',
            //     bs_balance: -profitloss
            //   }));

          })();
      });

    let subA = this
      .appService
      .filterOn('local:refresh:screen')
      .subscribe(d => {
        this.getFinalAccounts(this.navParams.get('type'));
      });

    // let subTest = this.appService.filterOn('tunnel:test').subscribe(
    //   d => { console.log(d) }
    // );
    this
      .subscriptions
      .add(subA);//.add(subTest);
  }
  ionViewDidEnter() {
    this.getFinalAccounts(this.navParams.get('type'));
  }

  getFinalAccounts(t) {
    this.type = t;
    this
      .appService
      .httpPost('tunnel:get:final:accounts', {
        args: {
          type: t
        }
      });
    // this.appService.httpPost('tunnel:test');
  }

  ledger(item) {
    this.navCtrl.push(LedgerPage, { accid: item.bs_acc_id });
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }

}
