import 'package:shared_preferences/shared_preferences.dart';

///This singleton class is responsible for managing the SharedPreferences.
class Prefs{
  //constants holding the keys to access the SharedPrefs data
  static const tokenKey="deviceToken";

  late SharedPreferences _sp;
  SharedPreferences get instance=>_sp;

  Future<void> init() async{
    _sp=await SharedPreferences.getInstance();
  }
  static final Prefs _singleton=Prefs._privateConstructor();

  factory Prefs(){
    return _singleton;
  }

  Prefs._privateConstructor(){
    init();
  }

}