import 'package:flutter/material.dart';
//import "dart:convert";
//import 'dart:async' show Future;
import 'ibuki.dart' as ibuki;
//import 'globals.dart' as globals;

class ProductDetails extends StatefulWidget {
  @override
  ProductDetailsState createState() {
    return ProductDetailsState();
  }
}

class ProductDetailsState extends State<ProductDetails> {
  dynamic subs;
  @override
  void initState() {
    subs = ibuki.filterOn('tunnel:get:product:details:on:prid').listen((d){
      print(d);
    });
//    globals.httpPost('tunnel:get:product:details:on:prid',
//        args: {'pr_id': globals.Util.get('id')}).then(
//        (d){
//          List<Map<String,dynamic>> resultSet = d;
//        }
//    );
    ibuki.httpPost('tunnel:get:product:details:on:prid');
    super.initState();
  }

  @override
  void dispose(){
    if(subs != null) subs.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget wid = SafeArea(
        child: Card(
            margin: EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text('Card test')
              ],
            )));

    return (wid);
  }
}
