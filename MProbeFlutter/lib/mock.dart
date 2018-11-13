import 'package:flutter/material.dart';
//import "dart:convert";
import 'dart:async';
//import 'dart:async' show Future;
import 'ibuki.dart' as ibuki;
//import 'globals.dart' as globals;

class Mock extends StatefulWidget {
  @override
  MockState createState() {
    return MockState();
  }
}

class MockState extends State<Mock> {
  StreamSubscription subs;
  List<dynamic> brandList = [
    {"brand": "videocon", 'isSelected': false}
  ];

  MockState();

  @override
  void initState() {
    getBrands();
    super.initState();
  }

  void getBrands() async {
    subs = ibuki.filterOn('tunnel:get:brands').listen((d) {
      setState(() {
        List<dynamic> resultSet = d['data'];
        brandList = resultSet.map((x) {
          return {'brand': x['brand'], 'isSelected': true};
        }).toList();
        // print(brandList);
      });
    });
    ibuki.httpPost('tunnel:get:brands', args: {});

   
//    dynamic d = await globals.httpPost('tunnel:get:brands', args: {});
//    List<Map<String, dynamic>> resultSet =
//        json.decode(d.body).cast<Map<String, dynamic>>();
//    setState(() {
//      brandList = resultSet.map((x) {
//        return {'brand': x['brand'], 'isSelected': true};
//      }).toList();
//      print(brandList);
//    });
  }

   @override
    void dispose() {
      subs.cancel();
      //  if (subs != null) subs.cancel();
      super.dispose();
    }

  void show(context) {
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
  }

  @override
  Widget build(BuildContext context) {
    Widget wid = Scaffold(
        appBar: AppBar(
          title: Text('Mock'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.threed_rotation),
              onPressed: () {
                show(context);
              },
            )
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
        ));
    return (wid);
  }
}
