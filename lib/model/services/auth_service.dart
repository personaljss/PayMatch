import 'package:pay_match/constants/network_constants.dart';
import 'package:http/http.dart' as http;
import 'package:pay_match/model/services/firebase_service.dart';
import 'dart:convert';

class AuthService{
  late String _password;
  String get password => _password;

  static final AuthService _instance=AuthService._privateConstructor();

  AuthService._privateConstructor(){
    _startSession();
  }

  factory AuthService(){
    return _instance;
  }

  void _startSession() async {
    //isset($_POST["devicetoken"]) && isset($_POST["key"]) && isset($_POST["value"]) && isset($_POST["size"])
    // return: json_encode(array('statu'=>$statu,'ps'=>$ps,'time'=>((microtime(true)-$init1)*1000)." ms"), JSON_UNESCAPED_UNICODE); statu: 0: success, 1: session already
    Uri url=Uri.parse(ApiAdress.server+ApiAdress.startSession);
    final response=await http.post(url,body: {
      "key":"1",
      "value":"1",
      "devicetoken":FirebaseService().deviceToken,
      "size":"4"
    });
    Map data=jsonDecode(response.body);
    if(data["statu"]!="404"){
      _password=data["ps"];
    }
  }

  //TODO: create a function that will  be called periodically to inform the server that the session should not be terminated
  void _continueSession(){
    //
  }

  Future<void> _endSession() async {
    //$postValid = isset($_POST["devicetoken"]) && isset($_POST["ps"]) && isset($_POST["usercode"]) && isset($_POST["key"]) && isset($_POST["value"]) && isset($_POST["size"]);
    // return: statu(0: success, 1: session does not exist, 404: system error.), time
  }

}
