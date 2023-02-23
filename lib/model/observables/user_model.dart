import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pay_match/constants/network_constants.dart';
import 'package:pay_match/model/data_models/base/Asset.dart';
import 'package:pay_match/model/data_models/trade/Orders.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  //late StocksModel stocksModel;

  //portfolio related
  NetworkState _portfolioState = NetworkState.LOADING;
  double _balance=0;
  double _equity=0;
  List<Transaction> _deals=[];
  List<Transaction> _orders=[];
  List<Asset> _assets=[];

  static const int _interval=10000;

  List<Asset> _allAssets=[];//all the assets
  Map<String,String> _symbolsMap= {};
  Map<String,dynamic> _iconsMap= {};


  UserModel() {
    _fetchSymbolNames();
    _fetchIcons();
    autoLoginServ();
  }

  Future<void> autoLoginServ()async{
    try{
      SharedPreferences sp=await SharedPreferences.getInstance();
      String deviceToken=sp.getString("deviceToken")!;
      Uri url=Uri.parse(ApiAdress.server+ApiAdress.autologin);
      final response=await http.post(url,body: {
        "key":"1",
        "value":"1",
        "devicetoken":deviceToken,
        "size":"4"
      });
      final data = jsonDecode(response.body);
      int statuR = data["statu"];
      if (statuR == 0) {
        status = LoginStatus.success;
        userCode = data["usercode"];
        _parseGroupData(data["groupdata"]);
        //updating the portfolio if successful login
        _updateData();
        Timer.periodic(const Duration(milliseconds: _interval), (Timer t) {
          _updateData();
        });
      } else if (statuR == 1) {
        status = LoginStatus.wrongInfo;
      } else if (statuR == 2) {
        status = LoginStatus.unverifiedAccount;
      } else {
        status = LoginStatus.systemError;
      }
    }catch(e){
      status=LoginStatus.wrongInfo;
    }

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

  //setters

  set allAssets(List<Asset> assets){
    _allAssets=assets;
    notifyListeners();
  }


  //getters

  List<Asset> get allAssets => _allAssets;
  Map<String,String> get symbolsMap=>_symbolsMap;
  Map<String,dynamic> get iconsMap =>_iconsMap;

  //methods
  Asset getAt(int index){
    return _allAssets[index];
  }


  //networking
  Future<void> _fetchSymbolNames() async{
    Uri url=Uri.parse(ApiAdress.server+ApiAdress.symbolNames);
    final response=await http.post(url,body: {
      "key":"1",
      "value":"1",
      "size":"3"
    });
    List symbols=jsonDecode(jsonDecode(response.body)["data"]);
    for(Map<String,dynamic> item in symbols){
      _symbolsMap[item["symbol"]]=item["sharename"];
    }
  }

  Future<void> _fetchIcons() async{
    //gereken postlar: isset($_POST["symbols"]) && isset($_POST["key"]) && isset($_POST["value"]) && isset($_POST["size"])
    Uri url=Uri.parse(ApiAdress.server+ApiAdress.icons);
    final response=await http.post(url,body: {
      "symbols":_symbolsMap.keys.join(","),
      "key":"1",
      "value":"1",
      "size":"4"
    });
    _iconsMap=jsonDecode(jsonDecode(response.body)["data"]);
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
      status=LoginStatus.loading;
      String? deviceToken=await FirebaseMessaging.instance.getToken();
      final response = await http.post(url, body: {
        'phone': phone,
        'password': password,
        'devicetoken':deviceToken,
        'key': '1',
        'value': '1',
        'size': '6',
      });
      print(response.body);
      final data = jsonDecode(response.body);
      int statuR = data["statu"];
      if (statuR == 0) {
        SharedPreferences sp=await SharedPreferences.getInstance();
        sp.setString("deviceToken", deviceToken!);
        status = LoginStatus.success;
        userCode = data["usercode"];
        _parseGroupData(data["groupdata"]);
        //updating the portfolio if successful login
        _updateData();
        Timer.periodic(const Duration(milliseconds: _interval), (Timer t) {
          _updateData();
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

  Future<void> _updateData() async {
    _fetchTransactions();
    await _fetchPortfolio();
    if (_portfolioState == NetworkState.LOADING) {
      portfolioState = NetworkState.DONE;
    }
  }

  //fav
  List<Asset> getAssetsInList(String listName) {
    List<Asset> list = [];
    for (Asset asset in allAssets) {
      try{
        if (lists[listName]!.contains(asset.symbol)) {
          list.add(asset);
        }
      }catch(e){
        print(e);
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
    if (!lists.containsKey(groupName)) {
      lists[groupName] = <String>[];
    }
    lists[groupName]!.add(symbol);
    notifyListeners();
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
      }if(!lists[groupName]!.contains(symbol)){
        lists[groupName]!.add(symbol);
        notifyListeners();
      }
    } else if (status == 1) {
      throw Exception("Share is already in the group");
    } else {
      throw Exception("System error");
    }
  }

  void deleteList(String listName){
    for(String symbol in lists[listName]!){
      deleteSymbolFromShareGroup(listName, symbol);
    }
    lists.remove(listName);
    lists=Map.of(lists);
  }

  Future<void> deleteSymbolFromShareGroup(String groupName, String symbol) async {

    if (lists.containsKey(groupName) && lists[groupName]!.contains(symbol)) {
      lists[groupName]!.remove(symbol);
      notifyListeners();
    }

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
      //
    }
  }

  //portfolio related methods

  Future<void> _fetchTransactions() async {
    print("_fetchTranaction():");
    Uri url = Uri.parse(ApiAdress.server + ApiAdress.transactions);
    final response = await http.post(url, body: {
      "usercode": userCode.toString(),
      "key": "1",
      "value": "1",
      "type": "sell_o,buy_o,sell,buy",
      "size": "6",
      "from":"0"
    });
    try{
      _parseTransactions(response);
    }catch(e){
      print("_parseTransactions(): $e");
    }
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
      "size": "4",
    });
    //print(response.body);
    _parseAssets(response);
  }

  //
  void _parseTransactions(Response response) {
    //print(jsonDecode(response.body));
    //{"tid":60,"usercode":1,"symbol":"RW","amount":80,"remaining":0,"price":1.2,"ts":2147483647,"statu":1,"startts":211313321}
    Map data = jsonDecode(jsonDecode(response.body)["data"]);

    List<Transaction> orderList = [];
    List<Transaction> dealList = [];

    // Parsing sell orders
    for (var item in data["sell"]) {
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
      ts.symbolName=symbolsMap[item["symbol"]]!;
      orderList.add(ts);
    }

    // Parsing buy orders
    for (var item in data["buy"]) {
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
      ts.symbolName=symbolsMap[item["symbol"]]!;
      orderList.add(ts);
    }

    // Parsing completed deals
    for (var item in data["sell_o"]) {
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
      ts.symbolName=symbolsMap[item["symbol"]]!;
      dealList.add(ts);
    }

    for (var item in data["buy_o"]) {
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
      ts.symbolName=symbolsMap[item["symbol"]]!;
      dealList.add(ts);
    }
    deals = Transaction.sortTimes(dealList);
    orders = Transaction.sortTimes(orderList);
  }

  void _parseAssets(Response response) {
    _equity=0;
    print(response.body);
    List<Asset> assetList = [];
    List<Asset> allList=[];
    String list = jsonDecode(response.body)["data"];
    double eq=0;
    for (var assetJson in jsonDecode(list)) {
      Asset asset = Asset.fromJson(assetJson);
      //profit calculation will be updated
      asset.profit = 0;

      //tl is not an asset it is the account balance
      if(asset.symbol=="TL"){
        balance=asset.amountHold;
        eq+=asset.amountHold;
        continue;
      }else{
        eq+=asset.amountHold*asset.bid;
      }
      try{
        asset.fullName = symbolsMap[asset.symbol]!;
        asset.logo=iconsMap[asset.symbol];
      }catch(e){
        //
      }
      allList.add(asset);
      if(asset.amountHold>0){
        assetList.add(asset);
      }
    }
    equity=eq;
    assets = assetList;
    allAssets=allList;
  }

  // isset($_POST["usercode"]) && isset($_POST["key"]) && isset($_POST["value"]) && isset($_POST["size"])
// && isset($_POST["symbol"]) && isset($_POST["amount"]) && isset($_POST["price"]) && isset($_POST["ts"]);
// (ts transactionun sonlanma süresi timestamp cinsinden. mesela eğer 1 günlükse şuanki timestamp + 86400)
  Future<TradeResponse> orderSend(TradeRequest request) async {
    try {
      if(balance<request.volume*request.price)return TradeResponse.noMoney;
      Uri url = Uri.parse(ApiAdress.getTradePage(request.orderType));
      int epochNow=DateTime.now().millisecondsSinceEpoch~/1000;
      //expiration will be handled
      final response = await http.post(url, body: {
        "usercode": userCode.toString(),
        "key": "1",
        "value": "1",
        "size": "8",
        "symbol": request.symbol,
        "amount": request.volume.toString(),
        "price": request.price.toString(),
        "ts": (epochNow<request.expiration)?request.expiration.toString():"4102444800"
      });
      TradeResponse tradeResponse = TradeResponse.systemError;
      Map data = jsonDecode(response.body);
      print("trade response$data");
      if (data["statu"] == 0) {
        tradeResponse = TradeResponse.success;
      } else if (data["statu"] == 1) {
        tradeResponse = TradeResponse.failure;
      }
      return tradeResponse;
    } catch (e) {
      print(e);
      return TradeResponse.systemError;
    }
  }
/*
  _saveLoginData(String phone, String password,String deviceToken)async{
    final prefs= await SharedPreferences.getInstance();
    prefs.setString("phone", phone);
    prefs.setString("password", password);
    prefs.setString("deviceToken", deviceToken);
  }

  Future<Map<String,String>> _getSavedLoginData() async{
    Map<String,String> data={};
    try{
      final SharedPreferences prefs=await SharedPreferences.getInstance();
      data["password"]=(prefs.getString("password"))!;
      data["phone"]=(prefs.getString("phone"))!;
    }catch(e){
      //
    }
    return data;
  }

 */

}
