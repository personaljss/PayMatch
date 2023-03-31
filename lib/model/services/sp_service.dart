import 'package:shared_preferences/shared_preferences.dart';

///This singleton class is responsible for managing the SharedPreferences.
class Prefs{
  //constants holding the keys to access the SharedPrefs data
  static const tokenKey="deviceToken";
  static const sessionPwdKey="sessionPwd";
  static const userCodeKey="userCode";
  static const phoneKey="phone";
  static const loginPwdKey="loginPassword";
  static const sessionLastUpdatedKey="session";

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

  String? getPhoneNumber() => _sp.getString(phoneKey);

  String? getLoginPassword() => _sp.getString(loginPwdKey);

  void savePhoneNumber(String phoneNumber){
    _sp.setString(phoneKey, phoneNumber);
  }

  void saveLoginPassword(String password){
    _sp.setString(loginPwdKey, password);
  }

  int? getLastUpdatedSession() => _sp.getInt(sessionLastUpdatedKey);
  void saveLastUpdatedSession(int time){
    _sp.setInt(sessionLastUpdatedKey, time);
  }
}