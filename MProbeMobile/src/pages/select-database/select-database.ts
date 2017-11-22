import {Component} from '@angular/core';
import {IonicPage, NavController, NavParams, ViewController} from 'ionic-angular';

@IonicPage()
@Component({selector: 'page-select-database', templateUrl: 'select-database.html'})
export class SelectDatabasePage {
  databases : any = [];
  constructor(public navCtrl : NavController, public navParams : NavParams, private viewCtrl : ViewController) {}

  ionViewDidLoad() {
    this.databases = this
      .navParams
      .get('databases')
      .sort();
  }

  cancel() {
    this
      .viewCtrl
      .dismiss(this);
  }

  selectDatabase(database : string) {
    this
      .viewCtrl
      .dismiss(this.parseDbString(database));
  }

  parseDbString(database) {
    let idx = database.indexOf(':') + 1;
    let userCode = database.substring(0, database.indexOf(':'));
    return ({
      database: database.substr(idx),
      userCode: userCode
    });
  }
}
