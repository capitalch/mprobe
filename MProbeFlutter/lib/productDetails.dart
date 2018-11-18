import 'package:flutter/material.dart';
//import "dart:convert";
//import 'dart:async' show Future;
import 'ibuki.dart' as ibuki;
import 'globals.dart' as globals;

class ProductDetails extends StatefulWidget {
  final int prId;
  ProductDetails(this.prId);
  @override
  ProductDetailsState createState() {
    return ProductDetailsState(prId);
  }
}

class ProductDetailsState extends State<ProductDetails> {
  // dynamic subs;
  final int prId;
  List<dynamic> productDetails = [];
  ProductDetailsState(this.prId);
  @override
  void initState() {
    super.initState();
    () async {
      dynamic d =
          await ibuki.filterOnFuture('tunnel:get:product:details:on:prid');
      setState(() {
        productDetails = d['data'];
        costGst = (productDetails[0] == null)
            ? 0.0
            : double.tryParse(productDetails[0]['gstcost']);
        gst = (productDetails[0] == null)
            ? 0.0
            : double.tryParse(productDetails[0]['gst']);
        print(productDetails);
      });
    }();

    ibuki.httpPost('tunnel:get:product:details:on:prid', args: {'pr_id': prId});
  }

  double salePrice = 0.0,
      profitPercent = 10.0,
      profit = 0.0,
      costGst = 0.0,
      gst = 0.0;

  void calculateProfit() {
    profit = (salePrice - costGst) * (1 - gst / 100);
  }

  void changeProfit(int i) {
    setState(() {
      if (i > 0) {
        profitPercent++;
      } else {
        // if (profitPercent >= 1) {
        profitPercent--;
        // }
      }
      calculateProfit();
    });
  }

  String getValue(item) {
    return ((productDetails.length > 0) ? productDetails[0][item] : '')
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    Widget wid = Scaffold(
      appBar: AppBar(
          title: Row(
        children: <Widget>[
          Expanded(
              child: (productDetails.length == 0)
                  ? Text('')
                  : Text(
                      productDetails[0]['item'] +
                          ' ' +
                          productDetails[0]['brand'] +
                          ' ' +
                          productDetails[0]['model'],
                      style: TextStyle(fontSize: 16.0),
                    )),
        ],
      )),
      body: Card(
          margin: EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 20.0),
                    width: 200,
                    child: Text(
                      'Last purchased on:',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20.0, top: 20.0),
                      width: 100,
                      child: Text(
                        getValue('last_pur_date'),
                        // productDetails[0]['last_pur_date'].toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ))
                ],
              ),
              Row(
                // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 20.0),
                    width: 200,
                    child: Text(
                      'Sold this year:',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20.0, top: 20.0),
                      width: 100,
                      child: Text(
                        getValue('cr'),
                        // productDetails[0]['cr'].toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ))
                ],
              ),
              Row(
                // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 20.0),
                    width: 200,
                    child: Text(
                      'Ageing:',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20.0, top: 20.0),
                      width: 100,
                      child: Text(
                        getValue('daysold'),
                        // productDetails[0]['daysold'].toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ))
                ],
              ),
              Row(
                // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 20.0),
                    width: 200,
                    child: Text(
                      'Stock:',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20.0, top: 20.0),
                      width: 100,
                      child: Text(
                        getValue('clos'),
                        // productDetails[0]['clos'].toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                child: Divider(color: Colors.brown, height: 5.0),
              ),
              Row(
                // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 20.0),
                    width: 200,
                    child: Text(
                      'Cost price basic:',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20.0, top: 20.0),
                      width: 100,
                      child: Text(
                        globals.Util.getFormatted1(getValue('basiccost')),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ))
                ],
              ),
              Row(
                // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 20.0),
                    width: 200,
                    child: Text(
                      'GST %:',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20.0, top: 20.0),
                      width: 100,
                      child: Text(
                        globals.Util.getFormatted1(getValue('gst')),
                        // productDetails[0]['gst'].toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ))
                ],
              ),
              Row(
                // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 20.0),
                    width: 200,
                    child: Text(
                      'Cost price with GST:',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20.0, top: 20.0),
                      width: 100,
                      child: Text(
                        globals.Util.getFormatted1(getValue('gstcost')),
                        // productDetails[0]['gstcost'].toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 25.0, color: Colors.purple
                        ),
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 10.0),
                child: Divider(color: Colors.brown, height: 5.0),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 10.0),
                    // width: 200,
                    child: Text(
                      'Sale price with GST:',
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      // width: 100,
                      child: Text(
                        () {
                          String s = getValue('gstcost');
                          s = (s == '') || (s == 'null') ? '0' : s;
                          double costGst = double.tryParse(s);
                          salePrice = costGst * (1.0 + profitPercent / 100);
                          return globals.Util.getFormatted1(salePrice);
                        }()
                            .toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 35.0,color: Colors.red
                        ),
                      ))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 10.0),
                    // width: 200,
                    child: Text(
                      'Profit:',
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      // width: 100,
                      child: Text(
                        () {
                          setState(() {
                            calculateProfit();
                          });
                          return (globals.Util.getFormatted1(profit));
                        }(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.blue
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      // width:100.0,
                      child: Text(
                        profitPercent.toString() + ' %',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 20.0, color: Colors.orange),
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 0.0, bottom: 0.0),
                child: Divider(color: Colors.brown, height: 5.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    iconSize: 65.0,
                    icon: Icon(
                      Icons.remove_circle,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      changeProfit(-1);
                    },
                  ),

                  // TextField(controller: TextEditingController.fromValue(TextEditingValue(text: '10.0')),),
                  IconButton(
                    iconSize: 65.0,
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      changeProfit(1);
                    },
                  ),
                ],
              )
            ],
          )),
    );

    // Widget wid = SafeArea(
    //     child: Card(
    //         margin: EdgeInsets.all(5.0),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.max,
    //           children: <Widget>[Text('Card test')],
    //         )));

    return (wid);
  }
}
