import 'package:flutter/material.dart';
import 'globals.dart' as globals;

getSearchAppBar({Function filterFn, bool isBusy}){
  return AppBar(
    leading: globals.Util.getBusyIndicator(isBusy),
      title: TextField(
        autofocus: true, keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white54),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white54,
          ),
        ),
        enabled: true,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white, fontSize: 20.0),
        onChanged: filterFn
      ),
    );
}

Widget getSearchBody({List<String> filteredList, Function onTapFn} ) {
    Widget wid;
    wid = ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (BuildContext context, int index) {
          return new ListTile(
            title: Text(filteredList[index]),
            onTap: 
            // onTapFn(filteredList[index]) 
            () => print(filteredList[index]),
          );
        });
    return wid;
  }