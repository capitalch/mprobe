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
                          globals.Util.set('id', brand);
                          Navigator.pushNamed(context, 'detailsOnBrand');
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
 
 */
