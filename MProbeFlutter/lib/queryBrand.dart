import 'package:flutter/material.dart';
// import "dart:convert";
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
  List<dynamic> brandList = [];
  dynamic subs;

  @override
  void initState() {
    List<String> sharedList;
    subs = ibuki.filterOn('tunnel:get:brands').listen((d) {
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
    });
    () async {
      sharedList = await getSharedList();
      ibuki.httpPost('tunnel:get:brands', args: {});
    }();
    // getBrands();
    super.initState();
  }

  @override
  void dispose() {
    subs.cancel();
    super.dispose();
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

  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget wid = Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _textController,keyboardType: TextInputType.text,style: TextStyle(fontSize: 20.0),
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search brand',
                suffixIcon: Icon(Icons.close),
                enabled: true,
                fillColor: Colors.white
                ),
          ),
        ),
        body: ListView.builder(
          itemCount: brandList.length,
          itemBuilder: (BuildContext context, int i) {
            Widget w = CheckboxListTile(
                secondary: Icon(
                  Icons.settings_system_daydream,
                  color: Colors.blue,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(brandList[i]['brand']),
                    Text(
                      brandList[i]['itemCount'].toString() + ' items',
                      textAlign: TextAlign.right,
                    )
                  ],
                ),
//                Text(brandList[i]['brand']),subtitle: Text(brandList[i]['itemCount'].toString()),
                value: brandList[i]['isSelected'],
                onChanged: (bool value) {
                  setState(() {
                    brandList[i]['isSelected'] = value;
                    setSharedBrand(brandList[i], value);
                  });
                });
            return (w);
          },
        ));
    return (wid);
  }
}

/*
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
