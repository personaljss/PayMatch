import 'package:pay_match/model/data_models/base/Asset.dart';
import 'package:pay_match/model/data_models/trade/Orders.dart';
import 'package:pay_match/model/observables/portfolio_model.dart';

/*
class PortfolioNetwork{
  static Future<PortfolioModel> fetchPortfolio() async {
    //fake impl
    PortfolioModel portfolio=PortfolioModel();
    return portfolio;
  }

  static Future<TradeResult> orderSend(TradeRequest request) async{
    //fake impl
    TradeResult res = await Future.delayed(const Duration(seconds: 2), () =>
        TradeResult.success("AAPL",
        "Apple Inc.",
        0,
        request.volume,
        request.price,
        request.price + 1,
        request.price - 1
    ));
    return res;
  }

}

 */