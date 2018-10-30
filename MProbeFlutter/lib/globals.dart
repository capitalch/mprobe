// library globalsLib;
import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import "dart:convert";
import 'package:intl/intl.dart'; // for number formatting

Future<dynamic> httpPost(String id, {dynamic args}) async {
  var settings = await rootBundle.loadString('assets/settings.json');
  var settingsObj = json.decode(settings);
  var client = http.Client();
  const String url = 'http://14.143.150.10:3004/api/tunnel';
  final body = {
    "type": "sql",
    "sqlKey": id,
    "dbName": settingsObj["dbName"],
    "toUid": "capital.chow.chowServer",
    "token": settingsObj["token"],
    "args": args
  };
  Future<dynamic> result = client.post(url,
      headers: {"Content-Type": "application/json"}, body: json.encode(body));

  return (result);
}

// final formatter1 = new NumberFormat("##,###");
// final formatter2 = new NumberFormat("##,###.##");

//formats a string / numeric in format1 ("###,###")
// String getFormatted1(dynamic val) {
//   var parsed = num.tryParse(val.toString());
//   String ret = (parsed == null) ? val : formatter1.format(parsed);
//   return (ret);
// }

class Util {
  static final _formatter1 = new NumberFormat("##,###");
  static final _formatter2 = new NumberFormat("##,###.##");
  static String getFormatted1(dynamic val) {
    var parsed = num.tryParse(val.toString());
    String ret = (parsed == null) ? val : _formatter1.format(parsed);
    return (ret);
  }
}
