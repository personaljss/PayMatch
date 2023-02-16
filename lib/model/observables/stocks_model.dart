import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pay_match/constants/network_constants.dart';
import '../data_models/base/Asset.dart';

class StocksModel with ChangeNotifier{
  static const int _interval=10000;
  NetworkState _allState=NetworkState.LOADING;
  List<Asset> _allAssets=[];//all the assets
  Map<String,String> _symbolsMap= {};
  Map<String,dynamic> _icons= {};

  StocksModel() {
    _fetchSymbolNames().then((value) {
      _updateAssets();
      _fetchIcons();
    }).catchError((e){
      allState=NetworkState.ERROR;
    });
    _fetchIcons();
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
    _icons=jsonDecode(jsonDecode(response.body)["data"]);
  }

  Future<void> _fetchAllAssets() async{
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
          allAssets=_parseStocks(response);
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

  Future<void> _updateAssets() async{
      Timer.periodic(const Duration(milliseconds: _interval),(Timer t)=>_fetchAllAssets());
  }

  List<Asset> _parseStocks(http.Response response)  {
    final List<dynamic> parsed = jsonDecode(json.decode(response.body)['data']);
    List<Asset> assets = [];
    for (var assetJson in parsed) {
      Asset asset=Asset.fromJson(assetJson);
      try{
        asset.fullName=_symbolsMap[asset.symbol]!;
        asset.logo=_icons[asset.symbol]!;
      }catch(e){
      }
      assets.add(asset);
    }

    return assets;
  }


}