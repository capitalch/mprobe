import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'reports.dart' as report;
import 'dart:convert';
import 'genericHelper.dart' as helper;

class Generic1 extends StatefulWidget {
  final String id;
  final Map<String, dynamic> args;
  final String pageTitle;
  final String reportId;
  Generic1(this.reportId, this.id, this.args, this.pageTitle);
  @override
  Generic1State createState() => Generic1State(reportId, id, args, pageTitle);
}

class Generic1State extends State<Generic1> {
  final String id;
  final Map<String, dynamic> args;
  final String pageTitle;
  final String reportId;
  bool isDateChangeButtonsVisible = false;
  double _ages = 0.9;
  double _indexes = 1.11;
  var resultSet = [];
  Generic1State(this.reportId, this.id, this.args, this.pageTitle) {
    isDateChangeButtonsVisible =
        report.reports[reportId]['isDateChangeButtonsVisible'] ?? false;
    populate();
  }

  void populate() {
    globals.httpPost(id, args: args).then((d) {
      setState(() {
        resultSet = json.decode(d.body).cast<Map<String, dynamic>>();
      });
      print(resultSet);
    }, onError: (ex) {
      print('Error1');
      print(ex);
    }).catchError((ex) {
      print('Error2');
      print(ex);
    });
  }

  void dateSubtract(d) {
    String dt = args["mdate"];
    DateTime dtPar = DateTime.tryParse(dt) ?? DateTime.now();
    dtPar = dtPar.subtract(Duration(days: 1));
    args["mdate"] = (dtPar.year.toString() +
        '-' +
        dtPar.month.toString() +
        '-' +
        dtPar.day.toString());
  }

  void dateAdd(d) {
    String dt = args["mdate"];
    DateTime dtPar = DateTime.tryParse(dt) ?? DateTime.now();
    dtPar = dtPar.add(Duration(days: 1));
    args["mdate"] = (dtPar.year.toString() +
        '-' +
        dtPar.month.toString() +
        '-' +
        dtPar.day.toString());
  }

  @override // TODO: implement context
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(bottom: PreferredSize(preferredSize:Size.fromHeight(10.0),child: Text('Test'),),
          title: Text(pageTitle),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () {
                setState(() {
                  resultSet = [];
                });
                populate();
              },
            ),
            isDateChangeButtonsVisible
                ? IconButton(
                    icon: Icon(Icons.arrow_left),
                    iconSize: 45.0,
                    color: Colors.red,
                    onPressed: () {
                      dateSubtract(1);
                      setState(() {
                        resultSet = [];
                      });
                      populate();
                    },
                  )
                : Container(),
            isDateChangeButtonsVisible
                ? IconButton(
                    icon: Icon(Icons.arrow_right),
                    color: Colors.red,
                    onPressed: () {
                      dateAdd(1);
                      setState(() {
                        resultSet = [];
                      });
                      populate();
                    },
                    iconSize: 45.0,
                  )
                : Container(),
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(20.0),
              child: SizedBox(
                  width: helper.getreportWidth(reportId),
                  child: helper.getReportBody(reportId, resultSet)),
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
/*

//  StreamSubscription subs;
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
 */
