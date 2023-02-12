import 'package:flutter/foundation.dart';
import 'package:pay_match/model/observables/stocks_model.dart';
import 'package:pay_match/model/observables/user_model.dart';

class FavsModel with ChangeNotifier{
  FavsModel({required this.userModel,required this.stocksModel});
  UserModel userModel;
  StocksModel stocksModel;

}