import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {BalanceSheetPage} from '../balance-sheet/balance-sheet';
import {ChequePaymentsPage} from '../cheque-payments/cheque-payments';
import {CashPaymentsPage} from '../cash-payments/cash-payments';
import {DebitCreditNotesPage} from '../debit-credit-notes/debit-credit-notes';
import {BanksPage} from '../banks/banks';

@IonicPage()
@Component({selector: 'page-accounts', templateUrl: 'accounts.html'})
export class AccountsPage {

  constructor(public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad AccountsPage');
  }

  balanceSheet() {
    this
      .navCtrl
      .push(BalanceSheetPage);
  }

  chequePayments() {
    this
      .navCtrl
      .push(ChequePaymentsPage);
  }

  cashPayments() {
    this
      .navCtrl
      .push(CashPaymentsPage);
  }

  debitNotes() {
    this
      .navCtrl
      .push(DebitCreditNotesPage, {
        class_db: '%',
        class_cr: 'PURCHASE',
        tempid: 0,
        type:'D'
      });
  }

  creditNotes() {
    this
      .navCtrl
      .push(DebitCreditNotesPage, {
        class_db: 'SALE',
        class_cr: '%',
        tempid: 0,
        type:'C'
      });
  }

  banks(){
    this.navCtrl.push(BanksPage)
  }

}
