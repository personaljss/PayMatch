import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pay_match/constants/network_constants.dart';
import '../data_models/base/Asset.dart';


///This is the view-model class of home page and the stocks page
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
      //allAssets=await StocksNetwork.fetchAllStocks();
      List<Asset> l=[];
      for(int i=0; i<20; i++){
        l.add(Asset(symbol: "symbol $i", sector: "N", amount: i.toDouble(), ask: i.toDouble(), bid: i.toDouble()));
      }
      allAssets=l;
      allState=NetworkState.DONE;
    }catch(e){
      allState=NetworkState.ERROR;
    }
  }

  Future<void> updateAssets() async{
    Timer.periodic(const Duration(milliseconds: 500),(Timer t)=>fetchAllAssets());
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