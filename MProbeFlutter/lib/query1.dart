import 'package:flutter/material.dart';
import "dart:convert";
import 'dart:async' show Future;
import 'globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class Query1 extends StatefulWidget {
  @override
  QueryState createState() {
    return QueryState();
  }
}

class QueryState extends State<Query1> {
  List<String> brandList = [];
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController();
    globals.Util.getSharedPreferences().then((p) {
      setState(() {
        brandList = p.getStringList('brands') ?? List<String>();
        brandList.sort((a, b) {
          return a.toLowerCase().compareTo(b.toLowerCase());
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void addBrand() async {
  if(_controller.text.isEmpty) return;
    if(!brandList.contains(_controller.text.toLowerCase())){
      dynamic sh = await globals.Util.getSharedPreferences();
      setState(() {
        brandList.add(_controller.text.toLowerCase());
        brandList.sort((a, b) {
          return a.toLowerCase().compareTo(b.toLowerCase());
        });
        sh.setStringList('brands', brandList);
      });
    }
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    Widget wd = Scaffold(
        appBar: AppBar(
          title: Text('Query'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.query_builder),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return new Scaffold(
                        backgroundColor: Colors.limeAccent,
                        body: new Container(
                            padding: const EdgeInsets.all(40.0),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new TextField(
                                  controller: _controller,
                                  autofocus: true,
                                  decoration:
                                      new InputDecoration(labelText: "Brand"),
                                  keyboardType: TextInputType.text,
                                ),
                                RaisedButton(
                                  child: Text('Submit'),
                                  onPressed: () {
                                    addBrand();
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            )),
                      );
                    });
              },
            )
          ],
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              ListTile(
                title: Text(brandList[index]),
              ),
          itemCount: brandList.length,
        ));
    return (wd);
  }
}
