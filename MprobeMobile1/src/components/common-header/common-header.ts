import {Component, Input} from '@angular/core';
import {AppServiceProvider} from '../../providers/app-service/app-service';
import {NavController} from 'ionic-angular';
// import * as _ from 'lodash';
import {LoginPage} from '../../pages/login/login';
// import {SelectDatabasePage} from '../../pages/select-database/select-database';
import {ModalController} from 'ionic-angular';

@Component({selector: 'common-header', templateUrl: 'common-header.html'})
export class CommonHeaderComponent {
  @Input()
  private title : string = '';
  mDatabase : string = 'Database';
  protected subscriptions : any;
  constructor(public modalCtrl : ModalController, public navCtrl : NavController, private appService : AppServiceProvider) {
    this.title = '';
    this
      .appService
      .getFromStorage('token')
      .then(token => {
        token || (this.navCtrl.push(LoginPage));
      });
    appService.checkNetwork();    
  }

  selectDatabase() {    
    this
      .appService
      .httpPost('post:retrieve:info', {key: 'clientInfo'});
  }

  ionViewWillUnload() {
    this
      .subscriptions
      .unsubscribe();
  }
}