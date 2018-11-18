import 'package:flutter/material.dart';
import 'ibuki.dart' as ibuki;
import 'dart:async' show Future;
import 'globals.dart' as globals;
import 'searchLib.dart' as search;
import 'package:shared_preferences/shared_preferences.dart';

class QueryBrand extends StatefulWidget {
  @override
  QueryBrandState createState() {
    return QueryBrandState();
  }
}

class QueryBrandState extends State<QueryBrand> {
  List<dynamic> brandList = [];
  List<dynamic> _filteredList = [];

  doInit() async {
    List<String> sharedList = await getSharedList();
    ibuki.httpPost('tunnel:get:brands', args: {});
    dynamic d = await ibuki.filterOnFuture('tunnel:get:brands');
    setState(() {
      brandList = d['data'].map((x) {
        return {
          'brand': x['brand'].toLowerCase(),
          'itemCount': x['itemcount'],
          'isSelected':
              sharedList.contains(x['brand'].toLowerCase()) ? true : false
        };
      }).toList();
    });
    _doFilter('');
  }

  @override
  void initState() {
    super.initState();
    doInit();
  }

  Future<List<String>> getSharedList() async {
    SharedPreferences shared = await globals.Util.getSharedPreferences();
    var tempList = shared.getStringList('brands') ?? [];
    return (tempList);
  }

  void setSharedBrand(value, isAdd) async {
    String brand = value['brand'].toLowerCase();
    SharedPreferences shared;
    shared = await globals.Util.getSharedPreferences();
    var sharedList = await getSharedList();
    if (isAdd) {
      if (!sharedList.contains(brand)) {
        sharedList.add(brand);
      }
    } else {
      if (sharedList.contains(brand)) {
        int index = sharedList.indexOf(brand);
        sharedList.removeAt(index);
      }
    }
    sharedList.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
    shared.setStringList('brands', sharedList);
  }

  
  _doFilter(String s) {
    setState(() {
      _filteredList = brandList.where((el) {
        return el['brand'].toLowerCase().contains(s.toLowerCase());
      }).toList();
    });
  }

  Widget getSearchBody() {
    Widget wid;
    wid = ListView.builder(
        itemCount: _filteredList.length,
        itemBuilder: (BuildContext context, int i) {
          Widget w = CheckboxListTile(
              secondary: Icon(
                Icons.settings_system_daydream,
                color: Colors.blue,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_filteredList[i]['brand']),
                  Text(
                    _filteredList[i]['itemCount'].toString() + ' items',
                    textAlign: TextAlign.right,
                  )
                ],
              ),
              value: _filteredList[i]['isSelected'],
              onChanged: (bool value) {
                setState(() {
                  _filteredList[i]['isSelected'] = value;
                  setSharedBrand(_filteredList[i], value);
                  if(_filteredList.length == 1){
                    Navigator.pop(context);
                  }
                });
              });
          return (w);
        });
    return wid;
  }

  @override
  Widget build(BuildContext context) {
    Widget wid = Scaffold(
      appBar: search.getSearchAppBar(filterFn: _doFilter),
      body:getSearchBody()
    );
    return (wid);
  }
}

/*

AppBar(
          title: TextField(
            controller: _textController,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 20.0),
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search brand',
                suffixIcon: Icon(Icons.close),
                enabled: true,
                fillColor: Colors.white),
          ),
        ),

void getBrands() async {
    dynamic d = await globals.httpPost('tunnel:get:brands', args: {});
    List<Map<String, dynamic>> resultSet =
        json.decode(d.body).cast<Map<String, dynamic>>();
    List<String> sharedList = await getSharedList();
    setState(() {
      brandList = resultSet.map((x) {
        return {
          'brand': x['brand'].toLowerCase(),
          'itemCount': x['itemcount'],
          'isSelected':
              sharedList.contains(x['brand'].toLowerCase()) ? true : false
        };
      }).toList();
      print(brandList);
    });
  }
*/
