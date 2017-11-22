import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams} from 'ionic-angular';
import {AppServiceProvider} from '../../providers/app-service/app-service';

@IonicPage()
@Component({selector: 'page-debit-credit-notes', templateUrl: 'debit-credit-notes.html'})
export class DebitCreditNotesPage {
  subscriptions : any;
  notes : any = [];
  type : string = '';
  constructor(public appService : AppServiceProvider, public navCtrl : NavController, public navParams : NavParams) {}

  ionViewDidLoad() {
    console.log('ionViewDidLoad DebitCreditNotesPage');
    this.type = this
      .navParams
      .get('type');
    this.subscriptions = this
      .appService
      .filterOn('tunnel:get:debit:credit:notes')
      .subscribe(d => {
        d.error
          ? console.log(d.error)
          : (() => {
            this.notes = d.data;
          })();
      });
    let subA = this
      .appService
      .filterOn('local:refresh:screen')
      .subscribe(d => {
        this.getDebitCreditNotes();
      });
    this
      .subscriptions
      .add(subA);
  }

  getDebitCreditNotes() {
    let class_db = this
      .navParams
      .get('class_db');
    let class_cr = this
      .navParams
      .get('class_cr');

    this
      .appService
      .httpPost('tunnel:get:debit:credit:notes', {        
        args: {
          class_db: class_db,
          class_cr: class_cr,
          tempid: 0
        }
      });
  }

  ionViewDidEnter() {
    this.getDebitCreditNotes();
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }

}
