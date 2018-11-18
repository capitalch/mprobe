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
  bool isBusy = false;

  doInit() async {
    final brand = globals.Util.get('id');
    ibuki.httpPost('tunnel:get:details:on:brand', args: {'brand': brand});
    isBusy = true;
    dynamic d = await ibuki.filterOnFuture('tunnel:get:details:on:brand');
    setState(() {
      productList = d['data'];
      isBusy = false;
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
        appBar: search.getSearchAppBar(filterFn: _doFilter,isBusy: isBusy),
        body: getSearchBody());
    return (wid);
  }
}
