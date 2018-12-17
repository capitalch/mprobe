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

        Row row = Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getBodyWidgets(reportId, resultSet[i]));

        InkWell ink = InkWell(
          child: row,
          onTap: () {
            String id = report.reports[reportId]["idName"];
            globals.Util.set('id', resultSet[i][id]);

            String route = report.reports[reportId]['drillDownReport'] ??
                report.reports[reportId]['drillDownRoute'];
            route == null ? () {} : Navigator.pushNamed(context, (route));
          },
        );
        return (ink);
      });

  return (widgets);
}

dynamic _summation(List<dynamic> myList, String name) {
  var out = myList.fold({name: 0.00}, (p, c) {
    return ({
      name: (num.tryParse((p[name] ?? 0).toString() ?? 0) +
          num.tryParse((c[name] ?? 0).toString() ?? 0))
    }); //if null
  });
  num res = num.tryParse((out[name] ?? 0).toString()) ?? 0;
  String fmt = globals.Util.getFormatted1(res);
  return (fmt);
}

dynamic getMultiItems(String item, dynamic result, dynamic compute) {
  dynamic out = '';
  if (compute != null) {
    out = compute(result);
  } else if (item.contains(',')) {
    List<String> items = item.split(',');
    items.forEach((x) {
      out = out + result[x] + ' ';
    });
  } else {
    out = result[item];
  }
  out = out ?? '';
  return (out);
}

dynamic getBodyWidgets(String id, dynamic result) {
  List<dynamic> body = report.reports[id]['body'];
  List<Widget> bodyWidget = List<Widget>();
  body.forEach((d) {
    String item = d['name'];
    dynamic compute = d['compute'];
    bodyWidget.add(Container(
      constraints: BoxConstraints(minHeight: 30.0),
      child: SizedBox(
          width: d["width"],
          // height: 30.0,
          child: Text(
            globals.Util.getFormatted1(getMultiItems(item, result, compute)),
            textAlign: _getAlignment(d),
          )),
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black12, width: 1.0))),
    ));
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

Widget getFixedBottomWidget(String reportId, dynamic resultSet) {
  List<Map<String, String>> fixedBottom =
      report.reports[reportId]['fixedBottom'];
  String fixed = "";
  dynamic getWidget = () {
    fixedBottom.forEach((x) {
      fixed = fixed + x['title'] + _summation(resultSet, x['name']) + ' ';
    });
    return (Text(
      fixed,
      style: TextStyle(color: Colors.red),
    ));
  };
  Widget out = (fixedBottom == null) ? Container() : getWidget();
  return (out);
}
