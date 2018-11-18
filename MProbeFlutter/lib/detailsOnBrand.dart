import 'package:flutter/material.dart';
import 'ibuki.dart' as ibuki;
import 'genericHelper.dart' as helper;
import 'globals.dart' as globals;
import 'searchLib.dart' as search;

class DetailsOnBrand extends StatefulWidget {
  @override
  DetailsOnBrandState createState() {
    return DetailsOnBrandState();
  }
}

class DetailsOnBrandState extends State<DetailsOnBrand> {
  List<dynamic> _filteredList = [];
  List<dynamic> productList = [];

  doInit() async {
    final brand = globals.Util.get('id');
    ibuki.httpPost('tunnel:get:details:on:brand', args: {'brand': brand});
    dynamic d = await ibuki.filterOnFuture('tunnel:get:details:on:brand');
    setState(() {
      productList = d['data'];
    });
    _doFilter('');
  }

  _doFilter(String s) {
    setState(() {
      _filteredList = productList.where((el) {
        return el['model'].toLowerCase().contains(s.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    doInit();
  }

  Widget getSearchBody() {
    Widget wid;
    wid = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(20.0),
      child:SizedBox(
        width: helper.getreportWidth('detailsOnBrand'),
        child: helper.getReportBody('detailsOnBrand', _filteredList),
      ),
    );
    return wid;
  }

  @override
  Widget build(BuildContext context) {
    Widget wid = Scaffold(
        appBar: search.getSearchAppBar(filterFn: _doFilter),
        body: getSearchBody());
    return (wid);
  }
}
