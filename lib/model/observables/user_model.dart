import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pay_match/constants/network_constants.dart';
import 'package:pay_match/model/data_models/base/Asset.dart';
import 'package:pay_match/model/observables/stocks_model.dart';
import 'package:pay_match/model/web_services/UserNetwork.dart';

enum LoginStatus {
  success,
  wrongInfo,
  unverifiedAccount,
  systemError,
  loading
}

class UserModel with ChangeNotifier {
  static const String defaultList="favoriler";
  late LoginStatus _status;
  late int _userCode;
  Map<String, List<String>> _lists={defaultList:["symbol 1","symbol 2"]};
  late String _time;
  late StocksModel _stocksModel;

  //synchronisation with stocks' data
  void syncWithStocks(StocksModel model){
    _stocksModel=model;
    notifyListeners();
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

  Map<String, dynamic> toJson() {
    return {
      'statu': status.index,
      'usercode': userCode,
      'groupdata': jsonEncode(lists),
      'time': time,
    };
  }

  void updateUserData(LoginStatus status, int userCode,
      Map<String, List<String>> lists, String time) {
    this.status = status;
    this.userCode = userCode;
    this.lists = lists;
    this.time = time;
  }

  Future<void> _loadLists() async {
    try {
      lists = await UserNetwork.fetchGroupData(userCode);
      notifyListeners();
    } catch (e) {
      //later
    }
  }

  Future<void> logIn(String phone, String password) async {
    try{
      Uri url=Uri.parse(ApiAdress.server+ApiAdress.login);
      status=LoginStatus.loading;
      final response=await http.post(url,body: jsonEncode(<String, dynamic>{
        'phone': phone,
        'password': password,
        'key': '1',
        'value': '1',
        'size': 5,
      }));
      final data=jsonDecode(response.body);
      int statuR=int.parse(data["statu"]);
      if(statuR==0){
        status=LoginStatus.success;
      }else if(statuR==1){
        status=LoginStatus.wrongInfo;
      }else if(statuR==2){
        status=LoginStatus.unverifiedAccount;
      }else{
        status=LoginStatus.systemError;
      }
      
      lists=_parseGroupData(data["groupdata"]);

    }catch(e){

    }
  }

  //fav
  List<Asset> getAssetsInList(String listName){
    List<Asset> list=[];
    for(Asset asset in _stocksModel.allAssets){
      if(lists[listName]!.contains(asset.symbol)){
        list.add(asset);
      }
    }
    return list;
  }

  void createShareGroupe(String listName){
    lists[listName]=[];
    notifyListeners();
  }

  void deleteShareGroup(String listName){
    lists.remove(listName);
    notifyListeners();
  }

  // statu: 404: system error, 0: success, 1: share is already in that group
  Future<void> addSymbolToShareGroup(String groupName, String symbol) async {
    Uri url=Uri.parse(ApiAdress.server+ApiAdress.lists);
    final response = await http.post(url, body: {
      "usercode": userCode,
      "groupname": groupName,
      "symbol": symbol,
      "type": "add",
      "key": 1,
      "value": 1,
      "size": 1,
    });

    final data = json.decode(response.body);
    final status = data['statu'];
    final time = data['time'];

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

  Future<void> deleteFromShareGroup(String groupName, String symbol) async {
    Uri url=Uri.parse(ApiAdress.server+ApiAdress.lists);
    final response = await http.post(url, body: {
      "usercode": userCode,
      "groupname": groupName,
      "symbol": symbol,
      "type": "del",
      "key": 1,
      "value": 1,
      "size": 1,
    });
    final data = json.decode(response.body);
    final status = data['statu'];

    if (status == 0) {
      if (lists.containsKey(groupName)) {
        lists[groupName]!.remove(symbol);
        if (lists[groupName]!.isEmpty) {
          lists.remove(groupName);
        }
      }
      notifyListeners();
    } else if (status == 1) {
      throw Exception("Share is not in the group");
    } else {
      throw Exception("System error");
    }
  }
  
  //utils
  Map<String, List<String>> _parseGroupData(String jsonString) {
    Map<String, List<String>> groups = Map();

    var jsonData = json.decode(jsonString);
    var groupData = jsonData['groupdata'];
    List groupDataList = json.decode(groupData);

    for (var group in groupDataList) {
      String groupName = group['groupname'];
      String symbol = group['symbol'];

      if (!groups.containsKey(groupName)) {
        groups[groupName] = [];
      }

      groups[groupName]?.add(symbol);
    }

    return groups;
  }

}




