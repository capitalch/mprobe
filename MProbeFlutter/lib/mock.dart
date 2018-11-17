import 'package:flutter/material.dart';
// import 'package:material_search/material_search.dart';
import "dart:convert";
import 'dart:async';
//import 'dart:async' show Future;
import 'ibuki.dart' as ibuki;
import 'globals.dart' as globals;

class Mock extends StatefulWidget {
  @override
  MockState createState() {
    return MockState();
  }
}

class MockState extends State<Mock> {
  final TextEditingController _filter = new TextEditingController();
  // final dio = new Dio(); // for http requests
  String _searchText = "";
  List names = new List(); // names we get from API
  List filteredNames = new List(); // names filtered by search text
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search Example');

  void _getNames() {
    List tempList = [
      'Sushant Agrawal',
      'Dick Anderson',
      'Moleu peacso',
      'Arged folio',
      'Peat soran',
      'Lala petric',
      'Peo harbinder'
    ];
    setState(() {
      names = tempList;
      filteredNames = names;
    });
  }

  @override
  void initState() {
    super.initState();
    _getNames();
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          controller: _filter,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text('Search Example');
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  MockState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  Widget _buildList() {
  if (!(_searchText.isEmpty)) {
    List tempList = new List();
    for (int i = 0; i < filteredNames.length; i++) {
      if (filteredNames[i]['name'].toLowerCase().contains(_searchText.toLowerCase())) {
        tempList.add(filteredNames[i]);
      }
    }
    filteredNames = tempList;
  }
  return ListView.builder(
    itemCount: names == null ? 0 : filteredNames.length,
    itemBuilder: (BuildContext context, int index) {
      return new ListTile(
        title: Text(filteredNames[index]['name']),
        onTap: () => print(filteredNames[index]['name']),
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {}
}
