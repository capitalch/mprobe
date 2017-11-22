import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {FinalAccountsPage} from '../final-accounts/final-accounts';
@IonicPage()
@Component({selector: 'page-balance-sheet', templateUrl: 'balance-sheet.html'})
export class BalanceSheetPage {

  constructor(public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad BalanceSheetPage');
  }

  finalAccounts(type) {
    this
      .navCtrl
      .push(FinalAccountsPage, {type: type});
  }
}
