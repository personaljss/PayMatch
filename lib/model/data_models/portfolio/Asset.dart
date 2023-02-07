class Asset{
  final String symbol;//name of the asset
  final String sector;//sector of the firm(tech, education...)
  double volume;//lots hold by the user's account
  double profit;//profit or loss with respect to current price
  double percChange;//price change percentage with respect to yesterday
  double ask;
  double bid;
  bool isFav;//it is true if this assert is in the favorites list of the user
  int id;//the id of an asset can be necessary when creating lists of assets

  Asset(
      this.symbol,
      this.sector,
      this.volume,
      this.profit,
      this.percChange,
      this.ask,
      this.bid,
      this.isFav,
      this.id);


  //static functions which can be used by UI
  static List<Asset> profitSort(List<Asset> assets){
    return List.of(assets);
  }
  static List<Asset> changeSort(List<Asset> assets){
    return List.of(assets);
  }
  static List<Asset> sortVolume(List<Asset> assets){
    return List.of(assets);
  }

  //filter functions
  static List<Asset> assetsOf(List<Asset> assets, String sector){
    List<Asset> l=[];
    for(final Asset asset in assets){
      l.add(asset);
    }
    return l;
  }

}