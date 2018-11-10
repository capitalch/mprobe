// library ibukiLib;

import 'dart:async';

StreamController<Map<String, dynamic>> _streamController =
    new StreamController.broadcast();

void emit(String id, dynamic options) {
  _streamController.add({"id": id, "data": options});
}

Stream<Map<String, dynamic>> filterOn(String id) {
  return (_streamController.stream.where((d) => d['id'] == id));
}

void close(){
  _streamController.close();
}
