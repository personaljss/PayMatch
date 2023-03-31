import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pay_match/model/services/sp_service.dart';

import '../../firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.data}");
}

///This singleton class is responsible for managing the Firebase services and holding the useful data from Firebase.
class FirebaseService{
  late String _deviceToken;

  String get deviceToken => _deviceToken;
  Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;

  Stream<RemoteMessage> get onPriceChange =>
     onMessage.asBroadcastStream().where((message) => message.data["type"]=="price");


  Stream<RemoteMessage> get onTransaction =>
      onMessage.asBroadcastStream().where((message) => message.data["type"]=="trans");

  Future<void> init() async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    _setToken();
    _refreshToken();
  }

  static final FirebaseService _instance=FirebaseService._privateConstructor();

  FirebaseService._privateConstructor();

  factory FirebaseService.instance() {
    return _instance;
  }

  void _setToken() async{
    try{
      if(Prefs.instance().getDeviceToken()!.isEmpty){
        _deviceToken=(await FirebaseMessaging.instance.getToken())!;
      }else{
        _deviceToken=Prefs.instance().getDeviceToken()!;
      }
    }catch(e){
      _deviceToken=(await FirebaseMessaging.instance.getToken())!;
    }
  }

  void _refreshToken(){
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      _deviceToken=token;
      Prefs.instance().saveDeviceToken(token);
    });
  }

}