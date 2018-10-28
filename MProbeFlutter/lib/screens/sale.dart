import 'package:flutter/material.dart';

class Sale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sale')),
        body:
            Center(child: RaisedButton(child: Text('Sale'), onPressed: () {})));
  }
}
