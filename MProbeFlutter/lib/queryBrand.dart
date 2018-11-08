import 'package:flutter/material.dart';
import "dart:convert";
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {

        },
        child: Text('Click'),
      ),
    );
  }
}
