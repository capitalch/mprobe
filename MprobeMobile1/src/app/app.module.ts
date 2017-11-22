import {BrowserModule} from '@angular/platform-browser';
import {ErrorHandler, NgModule} from '@angular/core';
import {IonicApp, IonicErrorHandler, IonicModule} from 'ionic-angular';
import {SplashScreen} from '@ionic-native/splash-screen';
import {StatusBar} from '@ionic-native/status-bar';
import {IonicStorageModule} from '@ionic/storage';
import {HttpModule} from '@angular/http';
import {CommonHeaderComponent} from '../components/common-header/common-header';
import {AppServiceProvider} from '../providers/app-service/app-service';
import {MyApp} from './app.component';
import {HomePage} from '../pages/home/home';
import {LoginPage} from '../pages/login/login';
import {BusinessPage} from '../pages/business/business';
import {AccountsPage} from '../pages/accounts/accounts';
import {SelectDatabasePage} from '../pages/select-database/select-database';
import {SaleHeaderPage} from '../pages/sale-header/sale-header';
import {HealthPage} from '../pages/health/health';
import {BalanceSheetPage} from '../pages/balance-sheet/balance-sheet';
import {ChequePaymentsPage} from '../pages/cheque-payments/cheque-payments';
import {CashPaymentsPage} from '../pages/cash-payments/cash-payments';
import {DebitCreditNotesPage} from '../pages/debit-credit-notes/debit-credit-notes';
import {FinalAccountsPage} from '../pages/final-accounts/final-accounts';
import {DatePicker} from '@ionic-native/date-picker';
import {JakarPage} from '../pages/jakar/jakar';
import {JakarDetailsPage} from '../pages/jakar-details/jakar-details';
import {SaleDetails1Page} from '../pages/sale-details1/sale-details1';
import {SaleDetails2Page} from '../pages/sale-details2/sale-details2';
import {SaleDetailsProductPage} from '../pages/sale-details-product/sale-details-product';
import {LedgerPage} from '../pages/ledger/ledger';
import {BanksPage} from '../pages/banks/banks';
import {BankDetailsPage} from '../pages/bank-details/bank-details';
import {OrdersPage} from '../pages/orders/orders';
import {OrderDetailsPage} from '../pages/order-details/order-details';
import {PlaceOrdersPage} from '../pages/place-orders/place-orders';
@NgModule({
  declarations: [
    MyApp,
    HomePage,
    CommonHeaderComponent,
    LoginPage,
    SelectDatabasePage,
    BusinessPage,
    AccountsPage,
    SaleHeaderPage,
    HealthPage,
    BalanceSheetPage,
    // ,AssetsPage,LiabilitiesPage,ExpencesPage,IncomePage
    FinalAccountsPage,
    ChequePaymentsPage,
    CashPaymentsPage,
    DebitCreditNotesPage,
    JakarPage,
    JakarDetailsPage,
    SaleDetails1Page,
    SaleDetails2Page,
    SaleDetailsProductPage,
    LedgerPage,
    BanksPage,
    BankDetailsPage,
    OrdersPage,
    OrderDetailsPage,
    PlaceOrdersPage
  ],
  imports: [
    BrowserModule, IonicModule.forRoot(MyApp, {backButtonText: ''}),
    IonicStorageModule.forRoot(),HttpModule
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    MyApp,
    HomePage,
    CommonHeaderComponent,
    LoginPage,
    SelectDatabasePage,
    BusinessPage,
    AccountsPage,
    SaleHeaderPage,
    HealthPage,
    BalanceSheetPage,
    // ,AssetsPage,LiabilitiesPage,ExpencesPage,IncomePage
    FinalAccountsPage,
    ChequePaymentsPage,
    CashPaymentsPage,
    DebitCreditNotesPage,
    JakarPage,
    JakarDetailsPage,
    SaleDetails1Page,
    SaleDetails2Page,
    SaleDetailsProductPage,
    LedgerPage,
    BanksPage,
    BankDetailsPage,
    OrdersPage,
    OrderDetailsPage,
    PlaceOrdersPage
  ],
  providers: [
    StatusBar,
    SplashScreen, {
      provide: ErrorHandler,
      useClass: IonicErrorHandler
    },
    AppServiceProvider,
    DatePicker
  ]
})
export class AppModule {}