import 'package:pay_match/model/data_models/trade/Orders.dart';

enum NetworkState{
  //http connection states
  LOADING,
  DONE,
  ERROR
}

class ApiAdress{
  //here is the location for backend urls
  static String server="https://hostingdenemesi.online/";
  static String login="records/login/";
  static String lists="records/sharegroups/";
  static String portfolio="transactions/portfolio/";
  static String importShare="records/importshare/";
  static String transactions="transactions/showtransactions/";
  static String sellOrder="transactions/sellorder/";
  static String buyOrder="transactions/buyorder/";
  static String symbolNames="records/symbolnames/";
  static String icons="records/geticons/";
  static String autologin="records/autologin/";
  static String onDispose="records/logout/";
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