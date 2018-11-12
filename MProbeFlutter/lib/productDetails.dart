import 'package:flutter/material.dart';
import "dart:convert";
import 'dart:async' show Future;
import 'ibuki.dart' as ibuki;
import 'globals.dart' as globals;

class ProductDetails extends StatefulWidget {
  @override
  ProductDetailsState createState() {
    return ProductDetailsState();
  }
}

void getProductDetails(){
  
}

class ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    Widget wid = SafeArea(
        child: Card(
            margin: EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[

              ],
            )));


    return (wid);
  }
}
