import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
import 'globals.dart' as globals;
import 'reports.dart' as report;
import 'package:intl/intl.dart'; 
import 'genericHelper.dart' as helper;
import 'ibuki.dart' as ibuki;

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
  String displayDate = '';
  bool isDateChangeButtonsVisible = false;
  bool isBusy = false;
  String detailsReport;
  var resultSet = [];
  Generic1State(this.reportId, this.id, this.args, this.pageTitle);
  dynamic subs;

  @override
  void initState() {
    super.initState();
    isDateChangeButtonsVisible =
        report.reports[reportId]['isDateChangeButtonsVisible'] ?? false;
    detailsReport = report.reports[reportId]['detailsReport'];
    subs = ibuki.filterOn(id).listen((d) {
      setState(() {
        resultSet = d['data'];
        isBusy = false;
      });
    });
    ibuki.httpPost(id, args: args);
    isBusy = true;
  }

  @override
  void dispose() {
    subs.cancel();
    super.dispose();
  }

  DateTime _getParsedDate() {
    String dt = args["mdate"];
    var func = () {
      List<String> dtArr = dt.split('-');
      //padLeft is used to convert day and month string from 1->01, 4->04 and so on.
      dt = dtArr[0] +
          '-' +
          dtArr[1].padLeft(2, '0') +
          '-' +
          dtArr[2].padLeft(2, '0');
      return (DateTime.parse(dt));
    };
    DateTime dtPar = dt == null ? DateTime.now() : func();
    return (dtPar);
  }

  void dateSubtract(d) {
    DateTime dtPar = _getParsedDate().subtract(Duration(days: 1));
    setState(() {
      args["mdate"] = (dtPar.year.toString() +
          '-' +
          dtPar.month.toString().padLeft(2, '0') +
          '-' +
          dtPar.day.toString().padLeft(2, '0'));
    });
    globals.Util.set('mdate', args["mdate"]);
    ibuki.httpPost(id, args: {"mdate": globals.Util.get('mdate')});
  }

  void dateAdd(d) {
    DateTime dtPar = _getParsedDate().add(Duration(days: 1));
    setState(() {
      args["mdate"] = (dtPar.year.toString() +
              '-' +
              dtPar.month.toString().padLeft(2, '0') +
              '-' +
              dtPar.day.toString())
          .padLeft(2, '0');
    });
    globals.Util.set('mdate', args["mdate"]);
    ibuki.httpPost(id, args: {"mdate": globals.Util.get('mdate')});
  }

  Widget _displayDateWidget() {
    DateTime dtPar = _getParsedDate();
    print(new DateFormat.yMMMd().format(new DateTime.now()));
    String fDate = DateFormat.yMMMd().format(dtPar);
    Widget wd = Text(
      fDate,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.yellow),
    );
    return (wd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: globals.Util.getBusyIndicator(isBusy),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(10.0),
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
                    child: _displayDateWidget()),
              ],
            ),
          ),
          title: Text(pageTitle),
          actions: <Widget>[
            (detailsReport != null)
                ? IconButton(
                    icon: Icon(Icons.ac_unit),
                    onPressed: () {
                      Navigator.pushNamed(context, 'detailedSales');
                    },
                  )
                : Container(),
            isDateChangeButtonsVisible
                ? IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.red,
                    onPressed: () {
                      dateSubtract(1);
                      setState(() {
                        resultSet = [];
                      });
                    },
                  )
                : Container(),
            isDateChangeButtonsVisible
                ? IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    color: Colors.red,
                    onPressed: () {
                      dateAdd(1);
                      setState(() {
                        resultSet = [];
                      });
                      ibuki.httpPost(id, args: {});
                    },
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
                bottom: 5.0,
                child: helper.getFixedBottomWidget(reportId, resultSet))
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
void populate() {
    // setState(() => isBusy = true);
    isBusy = true;
    globals.httpPost(id, args: args).then((d) {
      setState(() {
        resultSet = json.decode(d.body).cast<Map<String, dynamic>>();
        isBusy = false;
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
 */
