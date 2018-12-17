import 'package:flutter/material.dart';
import 'searchLib.dart' as search;

class Mock extends StatefulWidget {
  @override
  MockState createState() {
    return MockState();
  }
}

class MockState extends State<Mock> {
  List<String> _origList = [
    'Sushant Agrawal',
    'Dick Anderson',
    'Moleu peacso',
    'Arged folio',
    'Peat soran',
    'Lala petric',
    'Peo harbinder'
  ];
  List<String> _filteredList = [];

  _doFilter(String s) {
    setState(() {
      _filteredList = _origList.where((el) {
        return el.toLowerCase().contains(s.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _doFilter('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: search.getSearchAppBar(filterFn: _doFilter),
        body: search.getSearchBody(
            filteredList: _filteredList,
            onTapFn: (s) {
              print(s);
            }));
  }
}

/*
Widget _getBody() {
    Widget wid;
    wid = ListView.builder(
        itemCount: _filteredList.length,
        itemBuilder: (BuildContext context, int index) {
          return new ListTile(
            title: Text(_filteredList[index]),
            onTap: () => print(_filteredList[index]),
          );
        });
    return wid;
  }

// AppBar _getAppBar() {
  //   return AppBar(
  //     title: TextField(
  //       autofocus: true, keyboardType: TextInputType.text,
  //       decoration: InputDecoration(
  //         hintText: 'Search',
  //         hintStyle: TextStyle(color: Colors.white54),
  //         prefixIcon: const Icon(
  //           Icons.search,
  //           color: Colors.white54,
  //         ),
  //       ),
  //       enabled: true,
  //       cursorColor: Colors.white,
  //       style: TextStyle(color: Colors.white, fontSize: 20.0),
  //       onChanged: _doFilter
  //     ),
  //   );
  // }
*/
