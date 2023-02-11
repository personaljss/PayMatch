import 'dart:convert';

class Asset{
  final String symbol;//name of the asset
  final String sector;//sector of the firm(tech, education...)
  double amount;//lots hold by the user's account
  double ask;
  double bid;

  Asset({
    required this.symbol,
    required this.sector,
    required this.amount,
    required this.ask,
    required this.bid,});


  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      symbol: json['symbol'],
      sector: 'N/A',
      amount: json['amount'].toDouble(),
      ask: json['sellPrice'].toDouble(),
      bid: json['buyPrice'].toDouble(),
    );
  }

  static List<Asset> parseAssets(String responseBody) {
    final parsed = json.decode(responseBody)['data'];
    return List<Asset>.from(parsed.map((x) => Asset.fromJson(x)));
  }

}