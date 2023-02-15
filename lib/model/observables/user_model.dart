import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pay_match/constants/network_constants.dart';
import 'package:pay_match/model/data_models/base/Asset.dart';
import 'package:pay_match/model/data_models/trade/Orders.dart';
import 'package:pay_match/model/observables/stocks_model.dart';
import '../data_models/base/Transaction.dart';

enum LoginStatus {
  success,
  wrongInfo,
  unverifiedAccount,
  systemError,
  loading,
  notYet
}

class UserModel with ChangeNotifier {
  static const String defaultList = "favoriler";
  late LoginStatus _status = LoginStatus.notYet;
  late int _userCode;

  //lists created by user
  Map<String, List<String>> _lists = {defaultList: []};
  late String _time;

  //observable to create lists of asset
  late StocksModel stocksModel;

  //portfolio related
  NetworkState _portfolioState = NetworkState.LOADING;
  late double _balance;
  late double _equity;
  late List<Transaction> _deals;
  late List<Transaction> _orders;
  late List<Asset> _assets;

  UserModel({required this.stocksModel}) {
    logIn("905058257285", "dktrnnskt");
  }

  UserModel update(StocksModel model) {
    stocksModel = model;
    //notifyListeners();
    return this;
  }

  //getters and setters
  LoginStatus get status => _status;

  set status(LoginStatus value) {
    _status = value;
    notifyListeners();
  }

  int get userCode => _userCode;

  set userCode(int value) {
    _userCode = value;
    notifyListeners();
  }

  Map<String, List<String>> get lists => _lists;

  set lists(Map<String, List<String>> value) {
    _lists = value;
    notifyListeners();
  }

  String get time => _time;

  set time(String value) {
    _time = value;
    notifyListeners();
  }

  // portfolio related getters and setters
  double get balance => _balance;

  double get equity => _equity;

  List<Asset> get assets => _assets;

  List<Transaction> get deals => _deals;

  List<Transaction> get orders => _orders;

  NetworkState get portfolioState => _portfolioState;

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

  set assets(List<Asset> value) {
    _assets = value;
    notifyListeners();
  }

  set portfolioState(NetworkState state) {
    _portfolioState = state;
    notifyListeners();
  }

  //JSON converter
  Map<String, dynamic> toJson() {
    return {
      'statu': status.index,
      'usercode': userCode,
      'groupdata': jsonEncode(lists),
      'time': time,
    };
  }

  //login
  Future<void> logIn(String phone, String password) async {
    try {
      Uri url = Uri.parse(ApiAdress.server + ApiAdress.login);
      status = LoginStatus.loading;
      final response = await http.post(url, body: {
        'phone': phone,
        'password': password,
        'key': '1',
        'value': '1',
        'size': '5',
      });
      print(response.body);
      final data = jsonDecode(response.body);
      int statuR = data["statu"];
      if (statuR == 0) {
        status = LoginStatus.success;
        userCode = data["usercode"];
        //lists=_parseGroupData(data["groupdata"]);
        _parseGroupData(data["groupdata"]);
        //updating the portfolio if successful login
        Timer.periodic(const Duration(milliseconds: 2000), (Timer t) {
          _updatePortfolio();
        });
      } else if (statuR == 1) {
        status = LoginStatus.wrongInfo;
      } else if (statuR == 2) {
        status = LoginStatus.unverifiedAccount;
      } else {
        status = LoginStatus.systemError;
      }
    } catch (e) {
      print("login $e");
      status = LoginStatus.systemError;
    }
  }

  Future<void> _updatePortfolio() async {
    await _fetchTransactions();
    await _fetchPortfolio();
    if (_portfolioState == NetworkState.LOADING) {
      portfolioState = NetworkState.DONE;
    }
  }

  //fav
  List<Asset> getAssetsInList(String listName) {
    List<Asset> list = [];
    for (Asset asset in stocksModel.allAssets) {
      if (lists[listName]!.contains(asset.symbol)) {
        list.add(asset);
      }
    }
    return list;
  }

  void createShareGroup(String listName) {
    lists[listName] = [];
    notifyListeners();
  }

  void deleteShareGroup(String listName) {
    lists.remove(listName);
    notifyListeners();
  }

  // statu: 404: system error, 0: success, 1: share is already in that group
  Future<void> addSymbolToShareGroup(String groupName, String symbol) async {
    Uri url = Uri.parse(ApiAdress.server + ApiAdress.lists);
    final response = await http.post(url, body: {
      "usercode": _userCode.toString(),
      "groupname": groupName,
      "symbol": symbol,
      "type": "add",
      "key": "1",
      "value": "1",
      "size": "7",
    });

    final data = json.decode(response.body);
    final status = data['statu'];

    if (status == 0) {
      if (!lists.containsKey(groupName)) {
        lists[groupName] = <String>[];
      }
      lists[groupName]!.add(symbol);
      notifyListeners();
    } else if (status == 1) {
      throw Exception("Share is already in the group");
    } else {
      throw Exception("System error");
    }
  }

  Future<void> deleteSymbolFromShareGroup(
      String groupName, String symbol) async {
    Uri url = Uri.parse(ApiAdress.server + ApiAdress.lists);
    final response = await http.post(url, body: {
      "usercode": _userCode.toString(),
      "groupname": groupName,
      "symbol": symbol,
      "type": "del",
      "key": "1",
      "value": "1",
      "size": "7",
    });
    final data = json.decode(response.body);
    final status = data['statu'];

    if (status == 0) {
      if (lists.containsKey(groupName)) {
        lists[groupName]!.remove(symbol);
        /*
        if (lists[groupName]!.isEmpty) {
          lists.remove(groupName);
        }

         */
      }
      notifyListeners();
    } else if (status == 1) {
      throw Exception("Share is not in the group");
    } else {
      throw Exception("System error");
    }
  }

  //utils
  void _parseGroupData(String groupData) {
    try {
      final List<dynamic> parsed = jsonDecode(groupData);
      for (var item in parsed) {
        /*
        String listName=jsonDecode(item)['groupname'];
        String symbol=jsonDecode(item)['symbol'];
         */
        String listName = item['groupname'];
        String symbol = item['symbol'];
        if (lists.containsKey(listName)) {
          lists[listName]?.add(symbol);
        } else {
          List<String> l = List.generate(1, (index) => symbol);
          lists[listName] = l;
        }
      }
    } catch (e) {
      print("_parseGroupData $e");
    }
  }

  //portfolio related methods

  Future<void> _fetchTransactions() async {
    print("fetch trans called");

    Uri url = Uri.parse(ApiAdress.server + ApiAdress.transactions);
    final response = await http.post(url, body: {
      "usercode": userCode.toString(),
      "key": "1",
      "value": "1",
      "type": "sell_o,buy_o,sell,buy",
      "size": "5"
    });
    _parseTransactions(response);
  }

  Future<bool> deposit(double amount, String symbol) async {
    //isset($_POST["symbol"]) && isset($_POST["usercode"]) && isset($_POST["amount"]) && isset($_POST["key"]) && isset($_POST["value"]) && isset($_POST["size"]);
    Uri url = Uri.parse(ApiAdress.server + ApiAdress.importShare);

    final response = await http.post(url, body: {
      "symbol": symbol,
      "usercode": userCode.toString(),
      "amount": amount.toString(),
      "key": "1",
      "value": "1",
      "size": "6"
    });
    print(response.body);
    int status = jsonDecode(response.body)["statu"];
    if (status == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _fetchPortfolio() async {
    //--isset($_POST["usercode"]) && isset($_POST["key"]) && isset($_POST["value"]) && isset($_POST["size"]);
    Uri url = Uri.parse(ApiAdress.server + ApiAdress.portfolio);
    final response = await http.post(url, body: {
      "usercode": userCode.toString(),
      "key": "1",
      "value": "1",
      "size": "4"
    });
    _parseAssets(response);
  }

  //
  void _parseTransactions(Response response) {
    print(response);
    //{"tid":60,"usercode":1,"symbol":"RW","amount":80,"remaining":0,"price":1.2,"ts":2147483647,"statu":1,"startts":211313321}
    Map data = jsonDecode(jsonDecode(response.body)["data"]);

    List<Transaction> orderList = [];
    List<Transaction> dealList = [];

    // Parsing sell orders
    for (var item in data["sell_o"]) {
      Transaction ts = Transaction(
          id: item["tid"],
          symbol: item["symbol"],
          amount: item["amount"].toDouble(),
          remaining: item["remaining"].toDouble(),
          price: item["price"].toDouble(),
          expiration: item["ts"],
          status: TransStatus.values[item["statu"]],
          transType: TransType.sell,
          time: item["startTs"]);
      orderList.add(ts);
    }

    // Parsing buy orders
    for (var item in data["buy_o"]) {
      Transaction ts = Transaction(
          id: item["tid"],
          symbol: item["symbol"],
          amount: item["amount"].toDouble(),
          remaining: item["remaining"].toDouble(),
          price: item["price"].toDouble(),
          expiration: item["ts"],
          status: TransStatus.values[item["statu"]],
          transType: TransType.buy,
          time: item["startts"]);
      orderList.add(ts);
    }

    // Parsing completed deals
    for (var item in data["sell"]) {
      Transaction ts = Transaction(
          id: item["tid"],
          symbol: item["symbol"],
          amount: item["amount"].toDouble(),
          remaining: item["remaining"].toDouble(),
          price: item["price"].toDouble(),
          expiration: item["ts"],
          status: TransStatus.success,
          transType: item["bid_uid"] == 1 ? TransType.sell : TransType.buy,
          time: item["startts"]);
      dealList.add(ts);
    }

    for (var item in data["buy"]) {
      Transaction ts = Transaction(
          id: item["tid"],
          symbol: item["symbol"],
          amount: item["amount"].toDouble(),
          remaining: item["remaining"].toDouble(),
          price: item["price"].toDouble(),
          expiration: item["ts"],
          status: TransStatus.success,
          transType: item["bid_uid"] == 1 ? TransType.sell : TransType.buy,
          time: item["startts"]);
      dealList.add(ts);
    }
    deals = Transaction.sortTimes(dealList);
    orders = Transaction.sortTimes(orderList);
  }

  void _parseAssets(Response response) {
    print(response.body);
    List<Asset> assetList = [];
    String list = jsonDecode(response.body)["data"];
    for (var assetJson in jsonDecode(list)) {
      Asset asset = Asset.fromJson(assetJson);
      //profit calculation and setting fullname will be updated
      asset.profit = 0;
      asset.fullName = "DNE";
      assetList.add(asset);
    }
    assets = assetList;
  }

  // isset($_POST["usercode"]) && isset($_POST["key"]) && isset($_POST["value"]) && isset($_POST["size"])
// && isset($_POST["symbol"]) && isset($_POST["amount"]) && isset($_POST["price"]) && isset($_POST["ts"]);
// (ts transactionun sonlanma süresi timestamp cinsinden. mesela eğer 1 günlükse şuanki timestamp + 86400)
  Future<TradeResponse> orderSend(TradeRequest request) async {
    try {
      Uri url = Uri.parse(ApiAdress.getTradePage(request.orderType));
      final response = await http.post(url, body: {
        "usercode": userCode.toString(),
        "key": "1",
        "value": "1",
        "size": "8",
        "symbol": request.symbol,
        "amount": request.volume.toString(),
        "price": request.price.toString(),
        "ts": request.expiration.toString()
      });
      TradeResponse tradeResponse = TradeResponse.systemError;
      Map data = jsonDecode(response.body);
      if (data["Statü"] == 0) {
        tradeResponse = TradeResponse.success;
      } else if (data["Statü"] == 1) {
        tradeResponse = TradeResponse.failure;
      }
      return tradeResponse;
    } catch (e) {
      print(e);
      return TradeResponse.systemError;
    }
  }
}
