import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pay_match/model/services/sp_service.dart';

import '../../firebase_options.dart';

///This singleton class is responsible for managing the Firebase services and holding the useful data from Firebase.
class FirebaseService{
  late String _deviceToken;
  String get deviceToken => _deviceToken;

  Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;

  Future<void> init() async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _setToken();
    _refreshToken();
  }

  static final FirebaseService _instance=FirebaseService._privateConstructor();

  FirebaseService._privateConstructor(){
    init();
  }

  factory FirebaseService() {
    return _instance;
  }

  void _setToken() async{
    if(Prefs().instance.getString(Prefs.tokenKey)!.isEmpty){
      _deviceToken=(await FirebaseMessaging.instance.getToken())!;
    }else{
    _deviceToken=Prefs().instance.getString(Prefs.tokenKey)!;
    }
  }

  void _refreshToken(){
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      _deviceToken=event;
      Prefs().instance.setString(Prefs.tokenKey, event);
    });
  }

}