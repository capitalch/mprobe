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
  List<Map<String,dynamic>> brandList = [];
  List<bool> selectedList = [];
//  List<dynamic> brandList = [];
//  dynamic subs;
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
//    if(subs != null) subs.cancel();
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
        selectedList.add(true);
        return {'brand': x['brand'], 'isSelected': true};
      }).toList();
//      ibuki.emit('brand', {});
      print(brandList);
      print(selectedList);
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
              await getBrands();
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
                              CheckboxListTile tile = CheckboxListTile(
                                title: Text("abc"),
                                value: selectedList[i],
                                secondary: const Icon(Icons.hourglass_empty),
                                onChanged: (bool value) {
                                  setState(() {
//                                    brandList[i]['isSelected'] = value;
                                  selectedList[i] = value;
                                  });
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
