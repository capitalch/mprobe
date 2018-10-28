import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'dart:async';
import 'genericHelper.dart';
//import 'reports.dart' as xReports;
import "ibuki.dart" as ibuki;

//final String id;

class Generic1 extends StatefulWidget {
  final String id;
  final Map<String, String> args;
  Generic1(this.id, this.args) {}
  @override
  Generic1State createState() => Generic1State(id, args);
}

class Generic1State extends State<Generic1> {
  final String id;
  final Map<String, String> args;
  Generic1State(this.id, this.args) {populate();}

  void populate() {
    globals.httpPost(id, args: args).then((d) {
      print(d.body);
    }, onError: (ex) {
      print(ex);
    }).catchError((ex) {
      print(ex);
    });
  }

  StreamSubscription subs;
  List<dynamic> results = [];
  var _ages = 0;
  var _indexes = 0;
//  @override
//  Generic1State initState() {
//  subs = ibuki.filterOn('x').listen((d) {
//    setState(() {
//      results = d['data']['results'];
//      _ages = d['data']['ages'];
//      _indexes = d['data']['indexes'];
//    });
//  });
//    super.initState();
//  }

//  @override
//  dispose() {
////  subs.cancel();
//    super.dispose();
//  }

  @override // TODO: implement context
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Health')),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(20.0),
              child: SizedBox(width: 700.0, child: Text('Test')),
//            xReports.getReportBody(results)),
            ),
            Positioned(
                left: 20.0,
                bottom: 0.0,
                width: 700.0,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Ages: $_ages, Indexes: $_indexes',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    )))
          ],
        ));
  }
}
