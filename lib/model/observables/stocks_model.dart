import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pay_match/constants/network_constants.dart';
import '../data_models/base/Asset.dart';

class StocksModel with ChangeNotifier{
  NetworkState _allState=NetworkState.LOADING;
  List<Asset> _allAssets=[];//all the assets


  StocksModel(){
    updateAssets();
  }
  //setters
  set allState(NetworkState networkState){
    _allState=networkState;
    notifyListeners();
  }

  set allAssets(List<Asset> assets){
    _allAssets=assets;
    notifyListeners();
  }


  //getters
  NetworkState get allState => _allState;
  List<Asset> get allAssets => _allAssets;

  //methods
  Asset getAt(int index){
    return _allAssets[index];
  }


  //networking

  Future<void> fetchAllAssets() async{
    try{
      //post values and url should change bedirrahman celebi will create a new page
      Uri url=Uri.parse(ApiAdress.server+ApiAdress.portfolio);
        final response = await http.post(url,
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {
            'usercode': "1",
            'key': "1",
            'value': "1",
            'size': "4",
          },
        );

        if (response.statusCode == 200) {
          allAssets=Asset.parseAssets(response.body);
          allState=NetworkState.DONE;
        } else {
          throw Exception('Failed to fetch assets');
        }

      //now favAssets are set here but who knows where in future
    }catch(e){
      print(e);
      allState=NetworkState.ERROR;
    }
  }

  Future<void> updateAssets() async{
      Timer.periodic(const Duration(milliseconds: 2000),(Timer t)=>fetchAllAssets());
  }

  Future<List<Asset>> parseJson(String jsonString) async {
    final jsonData = json.decode(jsonString)['data'];
    List<Asset> assets = [];
    for (var assetJson in jsonData) {
      assets.add(Asset.fromJson(assetJson));
    }
    return assets;
  }

}