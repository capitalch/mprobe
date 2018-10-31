import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'dart:convert';
import 'genericHelper.dart' as helper;

class Generic1 extends StatefulWidget {
  final String id;
  final Map<String, String> args;
  final String pageTitle;
  final String reportId;
  Generic1(this.reportId, this.id, this.args, this.pageTitle) ;
  @override
  Generic1State createState() => Generic1State(reportId, id, args, pageTitle);
}

class Generic1State extends State<Generic1> {
  final String id;
  final Map<String, String> args;
  final String pageTitle;
  final String reportId;
  double _ages = 0.9;
  double _indexes = 1.11;
  var resultSet = [];
  Generic1State(this.reportId, this.id, this.args, this.pageTitle) {
    populate();
  }

  void populate() {
    globals.httpPost(id, args: args).then((d) {
      setState((){
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

  @override // TODO: implement context
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(pageTitle)),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(20.0),
            child: SizedBox(width: helper.getreportWidth(reportId), child:helper.getReportBody(reportId, resultSet)),
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