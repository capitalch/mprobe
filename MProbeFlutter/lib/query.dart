import 'package:flutter/material.dart';
import "dart:convert";
import 'dart:async' show Future;
import 'ibuki.dart' as ibuki;
import 'globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class Query extends StatefulWidget {
  @override
  QueryState createState() {
    return QueryState();
  }
}

class QueryState extends State<Query> {
//  List<String> brandList = [];
  List<dynamic> brandList = [];
  dynamic subs;
//  List<Map<String,dynamic>> resultSet = [];
  @override
  void initState() {
    super.initState();
    globals.Util.getSharedPreferences().then((p) {
      setState(() {
//        brandList = p.getStringList('brands') ?? List<String>();
//        brandList.sort((a, b) {
//          return a.toLowerCase().compareTo(b.toLowerCase());
//        });
      });
    });
  }

  @override
  void dispose() {
    if(subs != null) subs.cancel();
    super.dispose();
  }

//  void addBrand() async {
//    dynamic sh = await globals.Util.getSharedPreferences();
//    setState(() {
//      brandList.sort((a, b) {
//        return a.toLowerCase().compareTo(b.toLowerCase());
//      });
//      sh.setStringList('brands', brandList);
//    });
//  }

  void getBrands() async {
    dynamic d = await globals.httpPost('tunnel:get:brands', args: {});
    List<Map<String, dynamic>> resultSet =
        json.decode(d.body).cast<Map<String, dynamic>>();
    setState(() {
      brandList = resultSet.map((x) {
        return {"brand": x['brand'], "isSelected": false};
      }).toList();
//      ibuki.emit('brand', {});
      print(brandList);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget wd = Scaffold(
      appBar: AppBar(
        title: Text('Query'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              dynamic d = await globals.httpPost('tunnel:get:brands', args: {});
              List<Map<String, dynamic>> resultSet =
              json.decode(d.body).cast<Map<String, dynamic>>();
              setState(() {
                brandList = resultSet.map((x) {
                  return {"brand": x['brand'], "isSelected": false};
                }).toList();
                ibuki.emit('brand', {});
                print(brandList);
              });
              dynamic m = await globals.httpPost('tunnel:get:brands', args: {});
              List<Map<String, dynamic>> resultSet1 =
              json.decode(m.body).cast<Map<String, dynamic>>();
              setState(() {
                brandList = resultSet1.map((x) {
                  return {"brand": x['brand'], "isSelected": false};
                }).toList();
//                print(brandList);
              });
              showDialog(
                  context: context,
                  builder: (context) {
                    Widget wd = Scaffold(
                      appBar: AppBar(
                        title: Text('Add brands to query'),
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      body: ListView.builder(
                          itemCount: brandList.length,
                          itemBuilder: (BuildContext context, int i) {
//                            subs = ibuki.filterOn('brand').listen((d) {
//                              print(brandList);
//                              print(brandList.length);
                              CheckboxListTile tile = CheckboxListTile(
                                title: Text(brandList[i]['brand']),
                                value: brandList[i]['isSelected'],
                                onChanged: (bool value) {
                                  setState(() {});
                                },
                              );
                              return tile;
//                            });
                          }),
                    );
                    return (wd);
                  });
            },
          )
        ],
      ),
    );

    return (wd);
  }
}

/*

//    _controller = new TextEditingController();

//  TextEditingController _controller;
//    = Scaffold(
//        appBar: AppBar(
//          title: Text('Query'),
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.query_builder),
//              onPressed: () {
//                showDialog(
//                    context: context,
//                    builder: (context) {
//                      return new Scaffold(
//                        backgroundColor: Colors.limeAccent,
//                        body: new Container(
//                            padding: const EdgeInsets.all(40.0),
//                            child: new Column(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: <Widget>[
//                                new TextField(
//                                  controller: _controller,
//                                  autofocus: true,
//                                  decoration:
//                                  new InputDecoration(labelText: "Brand"),
//                                  keyboardType: TextInputType.text,
//                                ),
//                                RaisedButton(
//                                  child: Text('Submit'),
//                                  onPressed: () {
//                                    addBrand();
//                                    Navigator.pop(context);
//                                  },
//                                )
//                              ],
//                            )),
//                      );
//                    });
//              },
//            )
//          ],
//        ),
//        body: ListView.builder(
//          itemBuilder: (BuildContext context, int index) =>
//              ListTile(
//                title: Text(brandList[index]),
//              ),
//          itemCount: brandList.length,
//        ));
 */
