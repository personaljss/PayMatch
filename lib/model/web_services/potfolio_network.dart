import 'package:pay_match/model/data_models/portfolio/Asset.dart';
import 'package:pay_match/model/data_models/trade/Orders.dart';
import 'package:pay_match/model/observables/Portfolio.dart';

class PortfolioNetwork{
  static Future<Portfolio> fetchPortfolio() async {
    //fake impl
    Portfolio portfolio=Portfolio();
    return portfolio;
  }

  static Future<TradeResult> orderSend(TradeRequest request) async{
    //fake impl
    TradeResult res = await Future.delayed(const Duration(seconds: 2), () => TradeResult.success(
        0,
        request.volume,
        request.price,
        request.price + 1,
        request.price - 1
    ));
    return res;
  }

}