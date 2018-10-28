import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'dart:async' show Future;
//import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart'; // for number formatting
import 'dart:convert';
import 'globals.dart' as globals;

class Health extends StatefulWidget {
  @override
  HealthState createState() {
    return HealthState();
  }
}

class HealthState extends State<Health> {
  dynamic _healthSnapShot = {
    "opstockvalue": "",
    "closstockvalue": "",
    "stockover90days": "",
    "stockover180days": "",
    "stockover270days": "",
    "stockover360days": "",
    "profit": "",
    "grossprofit": ""
  };

  @override
  Widget build(BuildContext context) {
     globals.httpPost('tunnel:get:business:health').then((d) {
      if (mounted) {
        setState(() {
          dynamic healthList =
              json.decode(d.body); //.cast<Map<String, dynamic>>();
          if (healthList.length > 0) {
            _healthSnapShot = healthList[0];
          }
        });
      }
    });
    dynamic col = getColumn(_healthSnapShot);
    return Scaffold(
        appBar: AppBar(title: Text('Health')),
        body: Container(margin: EdgeInsets.all(40.0), child: col));
  }
}

dynamic getColumn(_healthSnapShot) {
  final formatter = new NumberFormat("##,###");
  dynamic col =
      Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Op Stock:',
          textAlign: TextAlign.left,
        ),
        Text(
          formatter.format(double.tryParse(_healthSnapShot['opstockvalue']) ?? 0),
          textAlign: TextAlign.right,
        )
      ],
    ),
    SizedBox(
      height: 20.0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Clos Stock:',
          textAlign: TextAlign.left,
        ),
        Text(
          formatter.format(double.tryParse(_healthSnapShot['closstockvalue']) ?? 0),
          textAlign: TextAlign.right,
        )
      ],
    ),
    SizedBox(
      height: 20.0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Stock over 90 Days:',
          textAlign: TextAlign.left,
        ),
        Text(
          formatter.format(double.tryParse(_healthSnapShot['stockover90days']) ?? 0),
          textAlign: TextAlign.right,
        )
      ],
    ),
    SizedBox(
      height: 20.0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Stock over 180 Days:',
          textAlign: TextAlign.left,
        ),
        Text(
          formatter.format(double.tryParse(_healthSnapShot['stockover180days']) ?? 0),
          textAlign: TextAlign.right,
        )
      ],
    ),
    SizedBox(
      height: 20.0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Stock over 270 Days:',
          textAlign: TextAlign.left,
        ),
        Text(
          formatter.format(double.tryParse(_healthSnapShot['stockover270days']) ?? 0),
          textAlign: TextAlign.right,
        )
      ],
    ),
    SizedBox(
      height: 20.0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Stock over 360 Days:',
          textAlign: TextAlign.left,
        ),
        Text(
          formatter.format(double.tryParse(_healthSnapShot['stockover360days']) ?? 0),
          textAlign: TextAlign.right,
        )
      ],
    ),
    SizedBox(
      height: 20.0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Profit:',
          textAlign: TextAlign.left,
        ),
        Text(
          formatter.format(double.tryParse(_healthSnapShot['profit']) ?? 0),
          textAlign: TextAlign.right,
        )
      ],
    ),
    SizedBox(
      height: 20.0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Gross Profit:',
          textAlign: TextAlign.left,
        ),
        Text(
          formatter.format(double.tryParse(_healthSnapShot['grossprofit']) ?? 0),
          textAlign: TextAlign.right,
        )
      ],
    ),
  ]);
  return (col);
}
