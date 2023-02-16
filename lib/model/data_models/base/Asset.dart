import 'dart:convert';

class Asset{
  final String symbol;//name of the asset
  final String sector;//sector of the firm(tech, education...)
  double amount;//lots hold by the user's account
  double ask;
  double bid;
  late double price;
  late String fullName;
  final double percChange;
  late double profit;

  Asset({
    required this.symbol,
    required this.sector,
    required this.amount,
    required this.ask,
    required this.bid,
    required this.fullName,
    required this.percChange});


  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      symbol: json['symbol'],
      sector: 'N/A',
      amount: json['onSaleAmount'].toDouble(),
      ask: json['sellPrice'].toDouble(),
      bid: json['buyPrice'].toDouble(),
      //not implemented yet
      fullName: 'DNE',
      percChange: 0
    );
  }

  static List<Asset> parseAssets(String responseBody) {
    final List<dynamic> parsed = jsonDecode(json.decode(responseBody)['data']);
    return List.generate(parsed.length, (index) => Asset.fromJson(parsed[index]));
  }

}