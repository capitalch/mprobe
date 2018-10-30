// library genericHelperLib;

import 'package:flutter/material.dart';
import 'reports.dart' as report;

dynamic getReportBody(resultSet) {
  dynamic widgets = ListView.builder(
      itemCount: resultSet.length + 2,
      itemBuilder: (BuildContext context, int i) {
        if (i == 0) {
          return Row(children: getHeaderWidgets("sales"));
        }
        ;

        if ((i == (resultSet.length + 1)) && (i != 0)) {
          return Row(children: getFooterWidgets("sales", resultSet));
//          return (Row(children: [Text('Test')]));
        }

        i = i - 1;

        return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getBodyWidgets("sales", resultSet[i]));
      });
  return (widgets);
}

dynamic summation(List<dynamic> myList, String name) {
  var out = myList.fold({name: 0.00}, (p, c) {
    return ({name: ( double.parse(p[name].toString()) + double.parse(c[name].toString()) )});
  });
  return (out[name].toString());
}

dynamic getBodyWidgets(String id, dynamic result) {
  List<dynamic> body = report.reports[id]['body'];
  List<Widget> bodyWidget = List<Widget>();
  body.forEach((d) {
    bodyWidget.add(
      SizedBox(
          width: d["width"], height: 30.0,
          child: Text(
            result[d["name"]].toString(),
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
        width: d["width"],height: 20.0,
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
//          ? Text('abc')
          ? Text(summation(resultSet, d["name"]).toString(), textAlign: TextAlign.right,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))
          : Text(''),
    ));
  });
  return (footerWidget);
}
