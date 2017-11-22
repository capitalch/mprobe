import {Component, ViewChild} from '@angular/core';
import {Platform, MenuController, Nav} from 'ionic-angular';
import {StatusBar} from '@ionic-native/status-bar';
import {SplashScreen} from '@ionic-native/splash-screen';
import {LoginPage} from '../pages/login/login';
import {HomePage} from '../pages/home/home';
import {AppServiceProvider} from '../providers/app-service/app-service';

@Component({templateUrl: 'app.html'})
export class MyApp {
  pages : any = [];
  rootPage : any = HomePage;
  @ViewChild(Nav)nav : Nav;
  constructor(private appService : AppServiceProvider, platform : Platform, statusBar : StatusBar, splashScreen : SplashScreen, private menu : MenuController) {
    this.pages = [
      {
        iosIcon: 'ios-paper',
        mdIcon: 'md-paper',
        title: 'Login',
        component: LoginPage
      }, {
        iosIcon: 'ios-paper',
        mdIcon: 'md-paper',
        title: 'Logout',
        component: LoginPage
      }
    ];
    platform
      .ready()
      .then(() => {
        statusBar.styleDefault();
        splashScreen.hide();
      });
  }
  login() {
    this
      .nav
      .push(LoginPage);
  }
  logout() {
    this
      .appService
      .logout();
    this
      .nav
      .push(HomePage);
  }
  openPage(page) {
    // close the menu when clicking a link from the menu
    this
      .menu
      .close();
    (page.title == 'Logout')
      ? (() => {
        this
          .appService
          .logout();
        this
          .nav
          .push(HomePage);
      })()
      : this
        .nav
        .push(page.component);
  }
}
