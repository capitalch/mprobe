import 'package:flutter/material.dart';
import 'reports.dart' as report;
import 'globals.dart' as globals;

dynamic getReportBody(reportId, resultSet) {
  dynamic widgets = ListView.builder(
      itemCount: resultSet.length + 2,
      itemBuilder: (BuildContext context, int i) {
        if (i == 0) {
          return Row(children: getHeaderWidgets(reportId));
        }
        if ((i == (resultSet.length + 1)) && (i != 0)) {
          return Row(children: getFooterWidgets(reportId, resultSet));
        }
        i = i - 1;
        return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getBodyWidgets(reportId, resultSet[i]));
      });
  return (widgets);
}

dynamic _summation(List<dynamic> myList, String name) {
  var out = myList.fold({name: 0.00}, (p, c) {
    return ({
      name: (num.tryParse(p[name].toString() ?? 0) +
          num.tryParse(c[name].toString() ?? 0))
    }); //if null
  });
  num res = num.tryParse(out[name].toString()) ?? 0;
  String fmt = globals.Util.getFormatted1(res);
  // String fmt = globals.formatter1.format(res);
  return (fmt);
}

dynamic getMultiItems(String item, dynamic result){
    // List<dynamic> body = report.reports[id]['body'];
    // body.forEach((x){
    //   String item = x["name"];
    dynamic out = '';
      if(item.contains(',')){
        List<String> items = item.split(',');
        items.forEach((x){
          out = out +  result[x] + ' ';
        });
        // print(items);
      } else {
        out = result[item];
      }
      return(out);
    // });
  }

dynamic getBodyWidgets(String id, dynamic result) {
  List<dynamic> body = report.reports[id]['body'];
  List<Widget> bodyWidget = List<Widget>();
  body.forEach((d) {
    String item = d['name'];
    bodyWidget.add(
      SizedBox(
          width: d["width"],
          // height: 30.0,
          child: Text(
            globals.Util.getFormatted1(getMultiItems(item, result)),
            // globals.Util.getFormatted1(result[d["name"]]),
            textAlign: _getAlignment(d),
          )),
    );
  });
  return (bodyWidget);
}

dynamic _getAlignment(dynamic d) {
  var align = TextAlign.left;
  if (d.containsKey("alignment")) {
    String ali = d['alignment'];
    if (ali == 'right') {
      align = TextAlign.right;
    } else if (ali == 'center') {
      align = TextAlign.center;
    }
  }
  return (align);
}

dynamic getHeaderWidgets(String id) {
  List<dynamic> header = report.reports[id]['body'];
  List<Widget> headerWidget = List<Widget>();
  header.forEach((d) {
    headerWidget.add(SizedBox(
        width: d["width"],
        height: 20.0,
        child: Text(d["title"],
            textAlign: _getAlignment(d),
            style:
                TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))));
  });
  return (headerWidget);
}

dynamic getFooterWidgets(String id, dynamic resultSet) {
  List<dynamic> footer = report.reports[id]['body'];
  List<Widget> footerWidget = List<Widget>();
  footer.forEach((d) {
    footerWidget.add(SizedBox(
      width: d["width"],
      child: d.containsKey("isSum")
          ? Text(_summation(resultSet, d["name"]).toString(),
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))
          : Text(''),
    ));
  });
  return (footerWidget);
}

double getreportWidth(String id) {
  List<dynamic> body = report.reports[id]['body'];
  double width = 0.0;
  body.forEach((x) {
    width = width + (double.tryParse(x["width"].toString()) ?? 0.0);
  });
  return (width + 2.0);
}

