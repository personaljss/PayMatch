import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/secondaries/trade.dart';


void displaySnackBar(BuildContext context,String txt){
  final snackBar = SnackBar(
    content: Text(txt),
    action: SnackBarAction(
      label: 'tamam',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

//functions
void gotoTradeView(BuildContext context,String symbolName) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TradeView(symbol: symbolName)));
}

String formatDateTime(int secondsSinceEpoch) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000);
  String formattedDate = "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString()}";
  return formattedDate;
}
