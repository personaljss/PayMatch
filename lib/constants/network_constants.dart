import 'package:pay_match/model/data_models/trade/Orders.dart';

enum NetworkState{
  //http connection states
  LOADING,
  DONE,
  ERROR
}

class ApiAdress{
  //here is the location for backend urls
  static String server="https://8e96-212-12-142-150.eu.ngrok.io/market/";
  static String login="login.php";
  static String lists="sharegroups.php";
  static String portfolio="portfolio.php";
  static String importShare="importshare.php";
  static String transactions="showtransactions.php";
  static String sellOrder="sellorder.php";
  static String buyOrder="buyorder.php";
  static String symbolNames="symbolnames.php";
  static String icons="geticons.php";
  static String getTradePage(OrderType orderType){
    if(orderType==OrderType.BUY_LIMIT){
      return server+buyOrder;
    }else if(orderType==OrderType.SELL_LIMIT){
      return server+sellOrder;
    }else{
      throw Exception("this order type has not a page in the server yet!");
    }
  }
}