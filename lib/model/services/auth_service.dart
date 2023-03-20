import 'dart:async';

import 'package:pay_match/constants/network_constants.dart';
import 'package:http/http.dart' as http;
import 'package:pay_match/model/services/firebase_service.dart';
import 'dart:convert';

enum LoginStatus {
  success,
  wrongInfo,
  unverifiedAccount,
  systemError,
  loading,
  notYet
}

class AuthService{
  static const String expiredPwd="expired";
  static const int refreshInterval=40000;

  late String _sessionPwd;
  String get sessionPwd => _sessionPwd;

  late String _userCode;
  String get userCode => _userCode;

  final StreamController<LoginStatus> _loginController=StreamController<LoginStatus>();
  Stream<LoginStatus> get loginStatus => _loginController.stream;

  static final AuthService _instance=AuthService._privateConstructor();

  AuthService._privateConstructor();

  factory AuthService.instance(){
    return _instance;
  }

  Future<void> init() async {
    await _startSession();
    Timer.periodic(const Duration(milliseconds: refreshInterval), (timer) {_refreshSession();});
  }

  /*
  Future<void> logIn(String phone, String password) async {
    try {
      Uri url = Uri.parse(ApiAdress.server + ApiAdress.login);
      _loginController.sink.add(LoginStatus.loading);
      final response = await http.post(url, body: {
        'phone': phone,
        'password': password,
        'devicetoken':FirebaseService.instance().deviceToken,
        'key': '1',
        'value': '1',
        'size': '7',
        "ps": sessionPwd,
      });

      final data = jsonDecode(response.body);
      int statuR = data["statu"];
      if (statuR == 0) {
        _loginController.sink.add(LoginStatus.success);
        _userCode=data["usercode"];
        _parseGroupData(data["groupdata"]);
        //updating the portfolio if successful login
        _updateData();
      } else if (statuR == 1) {
        status = LoginStatus.wrongInfo;
      } else if (statuR == 2) {
        status = LoginStatus.unverifiedAccount;
      } else {
        status = LoginStatus.systemError;
      }
    } catch (e) {

      status = LoginStatus.systemError;
    }
  }

   */

  Future<void> _startSession() async {
    //isset($_POST["devicetoken"]) && isset($_POST["key"]) && isset($_POST["value"]) && isset($_POST["size"])
    // return: json_encode(array('statu'=>$statu,'ps'=>$ps,'time'=>((microtime(true)-$init1)*1000)." ms"), JSON_UNESCAPED_UNICODE); statu: 0: success, 1: session already
    Uri url=Uri.parse(ApiAdress.server+ApiAdress.startSession);
    final response=await http.post(url,body: {
      "key":"1",
      "value":"1",
      "devicetoken":FirebaseService.instance().deviceToken,
      "size":"4"
    });
    print("session started: ${response.body}");
    Map data=jsonDecode(response.body);
    if(data["statu"]!="404"){
      _sessionPwd=data["ps"];
    }
  }

  //TODO: create a function that will  be called periodically to inform the server that the session should not be terminated
  Future<void> _refreshSession() async {
    //gereken postlar: devicetoken,ps,key,value,size
    // return: 0: başarılı, 403: devicetoken-ps eşleşmiyor, 404: system error
    print("refreshSession called: $sessionPwd");
    Uri url=Uri.parse(ApiAdress.server+ApiAdress.refreshSession);
    final response=await http.post(url,body: {
      "key":"1",
      "value":"1",
      "devicetoken":FirebaseService.instance().deviceToken,
      "ps":sessionPwd,
      "size":"5"
    });
    print("session refreshed: ${response.body}");
    Map data=jsonDecode(response.body);
    if(data["statu"]=="404"){
      throw Exception("System error while refreshing the session");
    }else if(data["statu"]=="403"){
      throw Exception("Session passwords do not match");
    }
  }

  Future<void> _endSession() async {
    //$postValid = isset($_POST["devicetoken"]) && isset($_POST["ps"]) && isset($_POST["usercode"]) && isset($_POST["key"]) && isset($_POST["value"]) && isset($_POST["size"]);
    // return: statu(0: success, 1: session does not exist, 404: system error.), time

  }



}
