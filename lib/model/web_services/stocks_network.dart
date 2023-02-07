import 'package:pay_match/model/data_models/portfolio/Asset.dart';

/// This class is for network operations required to get stocks' data without trading

class StocksNetwork{
  //returns all available assets traded
  static Future<List<Asset>> fetchAllStocks() async{
    //fake impl.
    List<Asset> assets=[];
    for (int i = 0; i < 20; i++) {
      assets.add(Asset("symbol $i", "sector $i", i.toDouble(), i.toDouble(),
          i % 2.toDouble(), i.toDouble(), i.toDouble(),(i%2==0),i));
    }
    assets=await Future.delayed(const Duration(seconds: 2),()=>assets);
    return assets;
  }

  //returns just the assets followed by user(for home page)
  /*
  static Future<List<Asset>> fetchFavStocks() async{
    //fake impl.
    List<Asset> assets=[];
    for (int i = 0; i < 10; i++) {
      assets.add(Asset("symbol", "sector", i.toDouble(), i.toDouble(),
          i % 2.toDouble(), i.toDouble(), i.toDouble()));
    }
    assets=await Future.delayed(const Duration(seconds: 2),()=>assets);
    return assets;
  }
   */

  //adds an asset to the following list
  static Future<bool> followAsset(Asset asset){
    //fake impl
    return Future.delayed(const Duration(seconds: 2),() => true);
  }

  //removes an asset from the following list
  static Future<bool> unFollowAsset(Asset asset){
    //fake impl
    return Future.delayed(const Duration(seconds: 2),() => true);
  }


}