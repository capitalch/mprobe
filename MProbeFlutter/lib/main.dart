import 'package:flutter/material.dart';
import 'health.dart';
// import 'mock.dart';
import 'generic1.dart';
import 'query.dart';
import 'queryBrand.dart';
import 'productDetails.dart';
import 'detailsOnBrand.dart';
import 'globals.dart' as globals;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'MProbe',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: {
        'health': (BuildContext context) {
          // print(globals.Util.get("id") ?? 0);
          return (Health());
        },
        'sales': (BuildContext context) {
          return (Generic1(
              "sales",
              "tunnel:get:todays:sale",
              {"mdate": globals.Util.get('mdate') ?? globals.Util.getDate()},
              "Sales"));
        },
        'saleDetails1': (BuildContext context) {
          return (Generic1(
              "saleDetails1",
              "tunnel:get:sale:details1",
              {
                "mdate": globals.Util.get('mdate') ?? globals.Util.getDate(),
                "master_id": globals.Util.get('id')
              },
              "Sale details"));
        },
        'saleDetails2': (BuildContext context) {
          return (Generic1(
              "saleDetails2",
              "tunnel:get:sale:details2",
              {
                "mdate": globals.Util.get('mdate') ?? globals.Util.getDate(),
                "bill_memo_id": globals.Util.get('id')
              },
              "Sale details further"));
        },
        'detailedSales': (BuildContext context) {
          return (Generic1(
              "detailedSales",
              "tunnel:get:sale:details:product",
              {"mdate": globals.Util.get('mdate') ?? globals.Util.getDate()},
              "Detailed sales"));
        },
        'orders': (BuildContext context) {
          return (Generic1("orders", "tunnel:get:orders", {}, "Orders"));
        },
        'orderDetails': (BuildContext context) {
          return (Generic1("orderDetails", "tunnel:get:order:details",
              {"counter": globals.Util.get('id')}, "Details"));
        },
        'chequePayments': (BuildContext context) {
          return (Generic1("chequePayments", "tunnel:get:cheque:payments", {},
              "Cheq payments"));
        },
        'cashPayments': (BuildContext context) {
          return (Generic1(
              "cashPayments", "tunnel:get:cash:payments", {}, "Cash payments"));
        },
        'debitNotes': (BuildContext context) {
          return (Generic1(
              "debitNotes",
              "tunnel:get:debit:credit:notes",
              {"class_db": '%', "class_cr": "PURCHASE", "tempid": 0},
              "Db notes"));
        },
        'creditNotes': (BuildContext context) {
          return (Generic1("creditNotes", "tunnel:get:debit:credit:notes",
              {"class_db": 'SALE', "class_cr": "%", "tempid": 0}, "Cr notes"));
        },
        'banks': (BuildContext context) {
          return (Generic1("banks", "tunnel:get:banks", {}, "Banks"));
        },
        'bankDetails': (BuildContext context) {
          return (Generic1("bankDetails", "tunnel:get:bank:recon:details",
              {"accIdbank": globals.Util.get('id')}, "Details"));
        },
        'jakar': (BuildContext context) {
          return (Generic1(
              "jakar", "tunnel:get:jakar:on:days", {"mdays": 360}, "Jakar"));
        },
        'jakarDetails': (BuildContext context) {
          return (Generic1(
              "jakarDetails",
              "tunnel:get:jakar:details",
              {"counter_code": globals.Util.get('id'), "mdays": 360},
              "Jakar details"));
        },
        'query':(BuildContext context){
          return(Query());
        },
        'queryBrands':(BuildContext context){
          return(QueryBrand());
        },
        'itemsOnBrand':(BuildContext context){
          final brand = globals.Util.get('id1');
          return Generic1(
            'itemsOnBrand',
            'tunnel:get:items:on:brand',
            {'brand':brand},
            '$brand items'
          );
        },
        'detailsOnBrand':(BuildContext context){
          return(DetailsOnBrand());
        },
        'detailsOnItemBrand':(BuildContext context){
          final item = globals.Util.get('id');
          final brand = globals.Util.get('id1');
          return Generic1(
            'detailsOnItemBrand',
            'tunnel:get:details:on:item:brand',
            {'item': item, 'brand': brand},
            '$item $brand details'
          );
        },
        'productDetails':(BuildContext context){
          final prId = globals.Util.get('id');
          return(ProductDetails(prId));
        },
        // 'mock':(BuildContext context){
        //   return(Mock());
        // }
      },
    );
  }
}

class EntryItem extends StatelessWidget {
  EntryItem(this.entry);
  final Entry entry;
  BuildContext _context;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty)
      return ListTile(
        title: Text(root.title),
        onTap: () {
          Navigator.of(_context).pushNamed(root.routeName);
        },
      );
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return _buildTiles(entry);
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  child: Text('Main menu'),
                  decoration: BoxDecoration(color: Colors.blue)),
              ListTile(
                title: Text('Login'),leading: Icon(Icons.account_circle),
                onTap: () {
                  Navigator.pop(context);
                },
              ),ListTile(
                title: Text('Query builder'), leading:Icon(Icons.query_builder),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),
          itemCount: data.length,
        ));
  }
}

class Entry {
  Entry(this.title, this.routeName, [this.children = const <Entry>[]]);
  final String title;
  final routeName;
  final List<Entry> children;
}

final List<Entry> data = <Entry>[
  Entry('Accounts', null, <Entry>[
    // Entry('Balance Sheet', 'balanceSheet'),
    Entry('Cheque Payments', 'chequePayments'),
    Entry('Cash payments', 'cashPayments'),
    Entry('Debit Notes', 'debitNotes'),
    Entry('Credit Notes', 'creditNotes'),
    Entry('Banks', 'banks')
  ]),
  Entry('Business', null, <Entry>[
    // Entry('Mock', 'mock'),
    Entry('Health', 'health'),
    Entry('Sales', 'sales'),    
    Entry('Detailed sales', 'detailedSales'),
    Entry('Query', 'query'),
    Entry('Orders', 'orders'),
    Entry('Jakar', 'jakar')
  ])
];
