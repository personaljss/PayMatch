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
  late double profit;
  late String imgFileLoc;

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