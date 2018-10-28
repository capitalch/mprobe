import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import "dart:convert";

Future<dynamic> httpPost(id) async {
  var settings = await rootBundle.loadString('assets/settings.json');
  var settingsObj = json.decode(settings);
  var client = http.Client();
  const String url = 'http://14.143.150.10:3004/api/tunnel';
  final body = {
    "type": "sql",
    "sqlKey": id,
    "dbName": settingsObj["dbName"],
    "toUid": "capital.chow.chowServer",
    "token": settingsObj["token"]
  };
  Future<dynamic> result = client.post(url, headers: null, body: body);
  return (result);
//  var health = await client.post(url, headers: null, body: body);
//  dynamic _dartObject = json.decode(health.body).cast<Map<String, dynamic>>();
//  return(_dartObject);
//  print(_dartObject);
}
