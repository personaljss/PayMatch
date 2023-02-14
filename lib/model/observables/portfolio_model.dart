import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:pay_match/constants/network_constants.dart';
import 'package:http/http.dart' as http;
import '../data_models/base/Transaction.dart';

class PortfolioModel with ChangeNotifier{
//isset($_POST["usercode"]) && isset($_POST["key"]) && isset($_POST["value"]) && isset($_POST["size"]) && isset($_POST["type"]);
// type: sell (satış transactionlarını), buy (alış transactionlarını), sell_o (tamamlanmış satış transactionlarını), buy_o (tamamlanmış alış transactionlarını) görüntüler. type'a bu 4'den biri girilmeli
// 0 veya 404 döner. 0 başarılı, 404 başarısız
  late final int userCode;
  late double _balance;
  late double _equity;
  late List<Transaction> _deals;
  late List<Transaction> _orders;

  // Getters and setters
  double get balance => _balance;
  double get equity => _equity;
  List<Transaction> get deals => _deals;
  List<Transaction> get orders => _orders;

  set balance(double value) {
    _balance = value;
    notifyListeners(); // Notify listeners that the balance has been updated
  }

  set equity(double value) {
    _equity = value;
    notifyListeners(); // Notify listeners that the equity has been updated
  }

  set deals(List<Transaction> value) {
    _deals = value;
    notifyListeners(); // Notify listeners that the deals have been updated
  }

  set orders(List<Transaction> value) {
    _orders = value;
    notifyListeners(); // Notify listeners that the orders have been updated
  }

  //constructor
  PortfolioModel({required this.userCode}){
   _fetchTransactions();
  }


  //portfolio
  Future<void> _fetchTransactions()async{
    print("fetch trans called");
    Uri url=Uri.parse(ApiAdress.server+ApiAdress.transactions);
    final response=await http.post(url, body: {
      "usercode": userCode.toString(),
      "key":"1",
      "value":"1",
      "type" : "sell_o,buy_o,sell,buy",
      "size" : "5"
    });
    _parseTransactions(response);
  }

  Future<bool> deposit(double amount, String symbol) async{
    //isset($_POST["symbol"]) && isset($_POST["usercode"]) && isset($_POST["amount"]) && isset($_POST["key"]) && isset($_POST["value"]) && isset($_POST["size"]);
    Uri url=Uri.parse(ApiAdress.server+ApiAdress.importShare);
    final response=await http.post(url, body:{
      "symbol": symbol,
      "usercode":userCode.toString(),
      "amount":amount.toString(),
      "key":"1",
      "value":"1",
      "size":"6"
    });
    print(response.body);
    int status=jsonDecode(response.body)["statu"];
    if(status==0){
      return true;
    }else{
      return false;
    }

  }

  void _parseTransactions(Response response){
    //{"tid":60,"usercode":1,"symbol":"RW","amount":80,"remaining":0,"price":1.2,"ts":2147483647,"statu":1,"startts":211313321}
    Map data = jsonDecode(jsonDecode(response.body)["data"]);

    List<Transaction> orderList = [];
    List<Transaction> dealList = [];

    // Parsing sell orders
    for(var item in data["sell_o"]){
      Transaction ts = Transaction(
          id: item["tid"],
          symbol: item["symbol"],
          amount: item["amount"].toDouble(),
          remaining: item["remaining"].toDouble(),
          price: item["price"].toDouble(),
          expiration: item["ts"],
          status: TransStatus.values[item["statu"]],
          orderType: TransType.sell,
          time: item["startTs"]
      );
      orderList.add(ts);
    }

    // Parsing buy orders
    for(var item in data["buy_o"]){
      Transaction ts = Transaction(
          id: item["tid"],
          symbol: item["symbol"],
          amount: item["amount"].toDouble(),
          remaining: item["remaining"].toDouble(),
          price: item["price"].toDouble(),
          expiration: item["ts"],
          status: TransStatus.values[item["statu"]],
          orderType: TransType.buy,
          time: item["startts"]
      );
      orderList.add(ts);
    }

    // Parsing completed deals
    for(var item in data["sell"]){
      Transaction ts = Transaction(
          id: item["tid"],
          symbol: item["symbol"],
          amount: item["amount"].toDouble(),
          remaining: item["remaining"].toDouble(),
          price: item["price"].toDouble(),
          expiration: item["ts"],
          status: TransStatus.success,
          orderType: item["bid_uid"] == 1 ? TransType.sell : TransType.buy,
          time: item["startts"]
      );
      dealList.add(ts);
    }

    for(var item in data["buy"]){
      Transaction ts = Transaction(
          id: item["tid"],
          symbol: item["symbol"],
          amount: item["amount"].toDouble(),
          remaining: item["remaining"].toDouble(),
          price: item["price"].toDouble(),
          expiration: item["ts"],
          status: TransStatus.success,
          orderType: item["bid_uid"] == 1 ? TransType.sell : TransType.buy,
          time: item["startts"]
      );
      dealList.add(ts);
    }
    deals=Transaction.sortTimes(dealList);
    orders=Transaction.sortTimes(orderList);
  }

}