import 'package:flutter/material.dart';
import "dart:convert";
import 'ibuki.dart' as ibuki;
import 'dart:async' show Future;
import 'globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class QueryBrand extends StatefulWidget {
  @override
  QueryBrandState createState() {
    return QueryBrandState();
  }
}

class QueryBrandState extends State<QueryBrand> {
  List<Map<String, dynamic>> brandList = [];

  @override
  void initState() {
    getBrands();
    super.initState();
  }

  Future<List<String>> getSharedList() async {
    SharedPreferences shared = await globals.Util.getSharedPreferences();
    var tempList = shared.getStringList('brands') ?? [];
    return(tempList);
  }

  void setSharedBrand(value, isAdd) async {
    String brand = value['brand'];
    SharedPreferences shared;
//    shared = await globals.Util.getSharedPreferences();
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

  void getBrands() async {
    dynamic d = await globals.httpPost('tunnel:get:brands', args: {});
    List<Map<String, dynamic>> resultSet =
        json.decode(d.body).cast<Map<String, dynamic>>();
    List<String> sharedList = await getSharedList();
    setState(() {
      brandList = resultSet.map((x) {
//        bool isContains = sharedList.contains(x);
        return {'brand': x['brand'], 'isSelected': false};
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget wid = Scaffold(
        appBar: AppBar(
          title: Text('Select brands to add'),
        ),
        body: ListView.builder(
          itemCount: brandList.length,
          itemBuilder: (BuildContext context, int i) {
            Widget w = CheckboxListTile(
                title: Text(brandList[i]['brand']),
                value: brandList[i]['isSelected'],
                onChanged: (bool value) {
                  setState(() {
                    brandList[i]['isSelected'] = value;
//                    (()async {
                      setSharedBrand(brandList[i], value);
//                    })();
                  });
                });
            return (w);
          },
        ));
    return (wid);
  }
}
