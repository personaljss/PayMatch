import 'package:flutter/material.dart';
import 'package:pay_match/model/services/firebase_service.dart';
import 'package:pay_match/model/services/sp_service.dart';

class ServiceManager{
  static Future<void> initialiseServices() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Prefs().init();
    await FirebaseService().init();
  }
}