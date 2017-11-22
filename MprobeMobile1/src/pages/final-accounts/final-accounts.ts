import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';
import {LedgerPage} from '../../pages/ledger/ledger';

@IonicPage()
@Component({selector: 'page-final-accounts', templateUrl: 'final-accounts.html'})
export class FinalAccountsPage {
  subscriptions : any;
  finalAccounts : [any];
  type : string;
  total : number = 0;
  constructor(public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {
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
            this.finalAccounts = d.data[0].Table;
            let profitloss = d.data[1].Table[0].profitloss;
            this.total = d.data[1].Table[0].total;
            (profitloss > 0)
              ? ((this.type == 'L') || (this.type == 'E')) && (this.finalAccounts.push({bs_name: 'Profit', bs_balance: profitloss}))
              : ((this.type == 'A') || (this.type == 'I')) && (this.finalAccounts.push({
                bs_name: 'Loss',
                bs_balance: -profitloss
              }));

          })();
      });

    let subA = this
      .appService
      .filterOn('local:refresh:screen')
      .subscribe(d => {
        this.getFinalAccounts(this.navParams.get('type'));
      });    

    this
      .subscriptions
      .add(subA);
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
      })
  }

  ledger(item) {   
    this.navCtrl.push(LedgerPage,{accid:item.bs_acc_id});
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }

}
