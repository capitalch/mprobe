import 'package:flutter/material.dart';
//import "dart:convert";
//import 'dart:async' show Future;
import 'ibuki.dart' as ibuki;
//import 'globals.dart' as globals;

class ProductDetails extends StatefulWidget {
  final int prId;
  ProductDetails(this.prId);
  @override
  ProductDetailsState createState() {
    return ProductDetailsState(prId);
  }
}

class ProductDetailsState extends State<ProductDetails> {
  dynamic subs;
  final int prId;
  dynamic productDetails = [];
  ProductDetailsState(this.prId);
  @override
  void initState() {
    subs = ibuki.filterOn('tunnel:get:product:details:on:prid').listen((d) {
      setState(() {
              productDetails=d['data'];
              print(productDetails);
            });
    });
    ibuki.httpPost('tunnel:get:product:details:on:prid', args: {'pr_id': prId});
    super.initState();
  }

  @override
  void dispose() {
    subs.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget wid = Scaffold(appBar:AppBar(
      title: Row(children: <Widget>[Text(productDetails.length > 0 ? '' : productDetails[0]['item'])],),
    ),);
    
    // Widget wid = SafeArea(
    //     child: Card(
    //         margin: EdgeInsets.all(5.0),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.max,
    //           children: <Widget>[Text('Card test')],
    //         )));

    return (wid);
  }
}
