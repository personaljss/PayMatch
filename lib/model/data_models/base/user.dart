import 'package:pay_match/model/data_models/base/Transaction.dart';
import 'Asset.dart';

///This singleton class is responsible for holding User data and managing user-related operations except authentication.
class User{
  late final String? id;

  static final User _instance=User._privateConstructor();

  User._privateConstructor();

  factory User.instance(){
    return _instance;
  }

  static void init(String userId){
    _instance.id=userId;
  }

}

