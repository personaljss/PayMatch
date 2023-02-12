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
  loading,

}

class UserModel with ChangeNotifier {
  static const String defaultList="favoriler";
  late LoginStatus _status=LoginStatus.loading;
  late int _userCode;
  Map<String, List<String>> _lists={defaultList:[]};
  late String _time;
  late StocksModel stocksModel;

  UserModel({required this.stocksModel}){
    if(status==LoginStatus.loading){
      logIn("905058257285", "dktrnnskt");
    }
  }

  UserModel update(StocksModel model){
    stocksModel=model;
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

  Map<String, dynamic> toJson() {
    return {
      'statu': status.index,
      'usercode': userCode,
      'groupdata': jsonEncode(lists),
      'time': time,
    };
  }

  Future<void> _loadLists() async {
    try {
      lists = await UserNetwork.fetchGroupData(userCode);
      notifyListeners();
    } catch (e) {
      //later
    }
  }

  //login
  Future<void> logIn(String phone, String password) async {
    try{
      Uri url=Uri.parse(ApiAdress.server+ApiAdress.login);
      status=LoginStatus.loading;
      final response=await http.post(url,body: {
        'phone': phone,
        'password': password,
        'key': '1',
        'value': '1',
        'size': '5',
      });
      print(response.body);
      final data=jsonDecode(response.body);
      int statuR=data["statu"];
      if(statuR==0){
        status=LoginStatus.success;
        userCode=data["usercode"];
        //lists=_parseGroupData(data["groupdata"]);
        print(data["groupdata"].runtimeType );
        _parseGroupData(data["groupdata"]);
      }else if(statuR==1){
        status=LoginStatus.wrongInfo;
      }else if(statuR==2){
        status=LoginStatus.unverifiedAccount;
      }else{
        status=LoginStatus.systemError;
      }

    }catch(e){
      print("login $e");
    }
  }


  //fav
  List<Asset> getAssetsInList(String listName){
    List<Asset> list=[];
    for(Asset asset in stocksModel.allAssets){
      if(lists[listName]!.contains(asset.symbol)){
        list.add(asset);
      }
    }
    return list;
  }

  void createShareGroup(String listName){
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
      "usercode": _userCode.toString(),
      "groupname": groupName,
      "symbol": symbol,
      "type": "add",
      "key": "1",
      "value":"1",
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

  Future<void> deleteSymbolFromShareGroup(String groupName, String symbol) async {
    Uri url=Uri.parse(ApiAdress.server+ApiAdress.lists);
    final response = await http.post(url, body: {
      "usercode": _userCode.toString(),
      "groupname": groupName,
      "symbol": symbol,
      "type": "del",
      "key": "1",
      "value":"1",
      "size": "7",
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
  void _parseGroupData(String groupData) {
    try{
      final List<dynamic> parsed = jsonDecode(groupData);
      for(var item in parsed){
        /*
        String listName=jsonDecode(item)['groupname'];
        String symbol=jsonDecode(item)['symbol'];
         */
        String listName=item['groupname'];
        String symbol=item['symbol'];
        if(lists.containsKey(listName)){
          lists[listName]?.add(symbol);
        }else{
          List<String> l=List.generate(1, (index) => symbol);
          lists[listName]=l;
        }
      }
    }catch(e){
      print("_parseGroupData $e");
    }
  }

  /*
  Map<String, List<String>> _parseGroupData(String groupData) {
    Map<String, List<String>> groups = {};
    final List<dynamic> parsed = jsonDecode(groupData);
    for(var item in parsed){
      String listName=jsonDecode(item)['groupname'];
      String symbol=jsonDecode(item)['symbol'];
      if(lists.containsKey(listName)){
        lists[listName]?.add(symbol);
      }else{
        List<String> l=List.generate(1, (index) => symbol);
        lists[listName]=l;
      }
    }
    return groups;
  }

   */


}




