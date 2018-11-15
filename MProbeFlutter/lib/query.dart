import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class Query extends StatefulWidget {
  @override
  QueryState createState() {
    return QueryState();
  }
}

class QueryState extends State<Query> {
  List<String> brandList = [];

  void getBrandsFromShared() async {
    SharedPreferences shared = await globals.Util.getSharedPreferences();
    setState(() {
      brandList = shared.getStringList('brands') ?? [];
    });
  }

  void removeBrand(int i) async {
    SharedPreferences shared = await globals.Util.getSharedPreferences();
    setState(() {
      brandList = shared.getStringList('brands') ?? [];
      brandList.removeAt(i);
      shared.setStringList('brands', brandList);
    });
  }

  @override
  void initState() {
    (() async {
      getBrandsFromShared();
    })();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget wd = Scaffold(
      appBar: AppBar(
        title: Text('Query'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, 'queryBrands');
            },
          )
        ],
      ),
      body: ListView.builder(
          itemCount: brandList.length,
          itemBuilder: (BuildContext context, int i) {
            final brand = brandList[i];

            Dismissible dis = Dismissible(
                key: Key(brand),
                onDismissed: (direction) {
                  removeBrand(i);
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('$brand dismissed')));
                },
                background: Container(color: Colors.red),
                child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(
                          Icons.developer_board,
                          color: Colors.blue,
                        ),
                        title: Text(brand),
                        onTap: () {
                          globals.Util.set('id1', brand);
                          Navigator.pushNamed(context, 'itemsOnBrand');
                        }),
                    Divider(
                      height: 1,
                      color: Colors.black,
                    )
                  ],
                ));

            return dis;
          }),
    );
    return (wd);
  }
}

/*
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
                            Widget w = CheckboxListTile(
                                title: Text(brandList[i]['brand']),
                                value: brandList[i]['isSelected'],
                                onChanged: (bool value) {
                                  setState(() {
                                    brandList[i]['isSelected'] = value;
                                  });
                                });
                            return (w);
                          },
                        ),
                    );
                    return (wd);
                  });
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
