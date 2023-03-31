import 'dart:convert';
import 'dart:typed_data';

class Asset {
  final String symbol; //name of the asset
  final String sector; //sector of the firm(tech, education...)
  double amountHold; //lots hold by the user's account
  //double amountOnSale;
  double ask;
  double bid;
  late double price;
  late String fullName;
  late String logo;
  late double percChange;
  double _profit=0;
  late String imgFileLoc;

  double get profit => _profit;
  double get cost => _cost;

  //variables to hold the amount of stock that is included in the profit calculation
  double _calculatedAmount=0;
  double _cost=0;

  void calculateProfit(double amountBought, double price){
    //print("$symbol: amountHold: $amountHold calculated: $_calculatedAmount");
    if(_calculatedAmount<amountHold){
      if(_calculatedAmount+amountBought<amountHold){
        _cost+=amountBought*price;
        _calculatedAmount+=amountBought;
      }else{
        _cost+=(amountHold-_calculatedAmount)*price;
        _calculatedAmount+=(amountHold-_calculatedAmount);
        _profit=amountHold*ask-_cost;
        //print("$symbol: amountHold: $amountHold ask: $ask cost: $_cost ");
      }
    }

  }

  Asset({
    required this.symbol,
    required this.sector,
    required this.amountHold,
    //required this.amountOnSale,
    required this.ask,
    required this.bid,
    required this.fullName,
    required this.percChange,
    required this.imgFileLoc});

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
        symbol: json['symbol'],
        sector: 'N/A',
        amountHold: double.parse(json['userhaving']),
        //amountOnSale: double.parse(json['onSaleAmount']),
        ask: double.parse(json['sellPrice']),
        bid: double.parse(json['buyPrice']),
        //not implemented yet
        fullName: 'DNE',
        percChange: 0,
        imgFileLoc: "https://hostingdenemesi.online/shareicons/${json['symbol']
            .toLowerCase()}.png"
    );
  }

  Uint8List get byteArrayImage => base64Decode(logo);

  static List<Asset> parseAssets(String responseBody) {
    final List<dynamic> parsed = jsonDecode(json.decode(responseBody)['data']);
    return List.generate(
        parsed.length, (index) => Asset.fromJson(parsed[index]));
  }

}