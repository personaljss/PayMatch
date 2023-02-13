import 'package:flutter/cupertino.dart';
import 'package:pay_match/constants/network_constants.dart';
import 'package:http/http.dart' as http;
import 'package:pay_match/model/observables/user_model.dart';

class PortfolioModel with ChangeNotifier{
//isset($_POST["usercode"]) && isset($_POST["key"]) && isset($_POST["value"]) && isset($_POST["size"]) && isset($_POST["type"]);
// type: sell (satış transactionlarını), buy (alış transactionlarını), sell_o (tamamlanmış satış transactionlarını), buy_o (tamamlanmış alış transactionlarını) görüntüler. type'a bu 4'den biri girilmeli
// 0 veya 404 döner. 0 başarılı, 404 başarısız
  late final int userCode;
  late double _balance;
  late double _equity;


  PortfolioModel({required this.userCode}){
   fetchTransactions();
  }
  //portfolio
  Future<void> fetchTransactions()async{
    print("fetch trans called");
    Uri url=Uri.parse(ApiAdress.server+ApiAdress.transactions);
    final response=await http.post(url, body: {
      "usercode": userCode.toString(),
      "key":"1",
      "value":"1",
      "type" : "sell_o",
      "size" : "5"
    }
    );
    print(response.body);
  }

}