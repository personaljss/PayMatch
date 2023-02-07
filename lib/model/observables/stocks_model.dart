import 'package:flutter/cupertino.dart';
import 'package:pay_match/constants/network_constants.dart';
import '../data_models/portfolio/Asset.dart';
import '../web_services/stocks_network.dart';

///This is the view-model class of home page and the stocks page
class StocksModel with ChangeNotifier{
  NetworkState _allState=NetworkState.LOADING;
  NetworkState _favState=NetworkState.LOADING;
  List<Asset> _favAssets=[];//assets followed by the user
  List<Asset> _allAssets=[];//all the assets

  StocksModel(){
    fetchFavAssets();
    fetchAllAssets();
  }
  //setters
  set allState(NetworkState networkState){
    _allState=networkState;
    notifyListeners();
  }
  set favState(NetworkState networkState){
    _favState=networkState;
    notifyListeners();
  }
  set allAssets(List<Asset> assets){
    _allAssets=assets;
    notifyListeners();
  }
  set favAssets(List<Asset> assets){
    _favAssets=assets;
    notifyListeners();
  }

  //getters
  NetworkState get allState => _allState;
  NetworkState get favState => _favState;
  List<Asset> get allAssets => _allAssets;
  List<Asset> get favAssets =>_favAssets;

  //methods
  Asset getFavAt(int index){
    return _favAssets[index];
  }

  Asset getAt(int index){
    return _allAssets[index];
  }

  //networking
  Future<void> fetchFavAssets() async{
    //impl can change
    try{
      for(Asset asset in allAssets){
        if(asset.isFav)favAssets.add(asset);
      }
      favState=NetworkState.DONE;
    }catch(e){
      favState=NetworkState.ERROR;
    }
  }

  Future<void> fetchAllAssets() async{
    try{
      allAssets=await StocksNetwork.fetchAllStocks();
      allState=NetworkState.DONE;
    }catch(e){
      allState=NetworkState.ERROR;
    }
  }

  Future<bool> followAsset(Asset asset) async{
    print(" before :${favAssets.length}");
    bool res=await StocksNetwork.followAsset(asset);
    if(res){
      asset.isFav=true;
      _favAssets.add(asset);
      notifyListeners();
      print(" after :${favAssets.length}");
    }
    return res;
  }

  Future<bool> unFollowAsset(Asset asset) async{
    bool res=await StocksNetwork.unFollowAsset(asset);
    if(res){
      asset.isFav=false;
      _favAssets.remove(asset);
      notifyListeners();
    }
    return res;
  }

}