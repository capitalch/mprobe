import 'package:flutter/material.dart';
import 'health.dart';
import 'generic1.dart';

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
        '/health': (BuildContext context) {
          return (Health());
        },
        '/sales': (BuildContext context) {
          DateTime today = DateTime.now();
          String mdate = today.year.toString() +
              '-' +
              today.month.toString() +
              '-' +
              today.day.toString();
          print(mdate);
          return (Generic1("tunnel:get:todays:sale", {"mdate": "2018-10-29"}, "Sales"));
        },
        '/detailedSales': (BuildContext context) {
          return (Generic1("tunnel:get:sale:details:product",
              {"mdate": "2018-10-29"}, "Detailed sales"));
        }
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
          Navigator.of(_context).pushNamed('/' + root.routeName);
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
    Entry('Balance Sheet', 'balanceSheet'),
    Entry('Cheque Payments', 'chequePayments'),
    Entry('Cash payments', 'cashPayments'),
    Entry('Debit Notes', 'debitNotes'),
    Entry('Credit Notes', 'creditNotes'),
    Entry('Banks', 'banks')
  ]),
  Entry('Business', null, <Entry>[
    Entry('Health', 'health'),
    Entry('Sales', 'sales'),
    Entry('Detailed sales', 'detailedSales'),
    Entry('Order', 'order')
  ])
];
