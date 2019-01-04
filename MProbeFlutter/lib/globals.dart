// library globalsLib;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import "dart:convert";
import 'package:intl/intl.dart'; // for date, number formatting
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> httpPost(String id, {dynamic args}) async {
  var settings = await rootBundle.loadString('assets/settings.json');
  var settingsObj = json.decode(settings);
  // const String url = 'http://14.143.150.10:3004/api/tunnel';
  const String url = 'http://chisel.cloudjiffy.net/api/tunnel';
  // const String url = 'http://10.0.2.2:3004/api/tunnel/static';
  final body = {
    "type": "sql",
    "sqlKey": id,
    "dbName": settingsObj["dbName"],
    "toUid": "capital.chow.chowServer",
    "token": settingsObj["token"],
    "args": args
  };

  Future<dynamic> result = http.post(url,
      headers: {"Content-Type": "application/json"}, body: json.encode(body));
  return (result);
}

dynamic httpPostMock() async {
  const String url = 'http://10.0.2.2:3004/test/timer';
  dynamic result = http.post((url));
  return (result);
}

Map<String, dynamic> packet = new Map();

class Util {
  static final _formatter1 = new NumberFormat("##,###");
  // static final _formatter2 = new NumberFormat("##,###.##");

  static String getFormatted1(dynamic val) {
    var parsed = num.tryParse(val.toString());
    String ret = (parsed == null) ? val : _formatter1.format(parsed);
    return (ret);
  }

  static String getDate() {
    DateTime today = DateTime.now();
    String mdate = today.year.toString() +
        '-' +
        today.month.toString() +
        '-' +
        today.day.toString();
    return (mdate);
  }

  static dynamic get(id) {
    return (packet[id]);
  }

  static void set(id, value) {
    packet[id] = value;
  }

  static Future<SharedPreferences> getSharedPreferences() {
    return (SharedPreferences.getInstance());
  }

  static Widget getBusyIndicator(bool isBusy) {
    isBusy = isBusy ?? false;
    Widget wid = isBusy
        ? Padding(
            padding: EdgeInsets.only(left: 30.0),
            child: CupertinoActivityIndicator(
              radius: 10.0,
              animating: true,
            ),
          )
        : null;
    return (wid);
  }
}

//  static loadCounter() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//  }

//  static dynamic getShared(String key){
//    dynamic prefs = () async {
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      dynamic value = prefs.getInt(key);
//      return value;
//    };
//    return(prefs.getInt(key));
//  }

//  static void setShared(String key, dynamic value){
//    dynamic prefs = () async {
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      prefs.setInt(key,value);
//    };
//    prefs();
//  }
