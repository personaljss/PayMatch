import 'package:shared_preferences/shared_preferences.dart';

///This singleton class is responsible for managing the SharedPreferences.
class Prefs{
  //constants holding the keys to access the SharedPrefs data
  static const tokenKey="deviceToken";
  static const sessionPwdKey="sessionPwd";
  static const userCodeKey="userCode";

  late SharedPreferences _sp;
  SharedPreferences get data=>_sp;

  Future<void> init() async{
    _sp=await SharedPreferences.getInstance();
  }
  static final Prefs _singleton=Prefs._privateConstructor();

  factory Prefs.instance(){
    return _singleton;
  }

  Prefs._privateConstructor(){
    init();
  }

  saveSessionPassword(String password){
    _sp.setString(sessionPwdKey, password);
  }

  String? getSessionPassword(){
    return _sp.getString(sessionPwdKey);
  }

  saveDeviceToken(String token){
    _sp.setString(tokenKey, token);
  }

  String? getDeviceToken(){
    return _sp.getString(tokenKey);
  }

  saveUserCode(String usercode){
    _sp.setString(userCodeKey, usercode);
  }

  String? getUserCode(){
    return _sp.getString(userCodeKey);
  }

}