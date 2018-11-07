import 'package:flutter/material.dart';
import "dart:convert";
import 'globals.dart' as globals;

class Query extends StatefulWidget {
  @override
  QueryState createState() {
    return QueryState();
  }
}

class QueryState extends State<Query> {
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
                    Container(width: 0.0,height: 0.0, child: Text(''),);
                  });
            },
          )
        ],
      ),
    );
    return (wd);
  }
}
