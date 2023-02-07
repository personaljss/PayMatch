import 'package:flutter/cupertino.dart';
import 'package:pay_match/model/web_services/potfolio_network.dart';
import '../data_models/portfolio/Asset.dart';

class Portfolio with ChangeNotifier{
  late List<Asset> _assets;
  late double _balance;
  late double _equity;

  //setters
  set assets(List<Asset> assets){
    _assets=assets;
    notifyListeners();
  }

  set balance(double balance){
    _balance=balance;
    notifyListeners();
  }

  set equity(double equity){
    _equity=equity;
    notifyListeners();
  }

  //getters
  List<Asset> get assets => _assets;
  double get equity => _equity;
  double get balance => _balance;

  Future<void> fetchPortfolio() async{
    Portfolio portfolio=await PortfolioNetwork.fetchPortfolio();
    assets=portfolio.assets;
    balance=portfolio.balance;
    equity=portfolio.equity;
  }

  double getProfit(){
    double sum=0;
    for(Asset asset in assets){
      sum+=asset.profit;
    }
    return sum;
  }

  void addAsset(Asset asset){
    _assets.add(asset);
    notifyListeners();
  }

  void removeAsset(Asset asset){
    _assets.remove(asset);
    notifyListeners();
  }

  //sort functions with respect to the assets' fields
  void profitSort(){

  }
  void changeSort(){

  }
  void sortVolume(){

  }
  //filter functions
  List<Asset> assetsOf(String sector){
    List<Asset> l=[];
    for(final Asset asset in assets){
      l.add(asset);
    }
    return l;
  }

}