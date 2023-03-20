import 'package:flutter/material.dart';
import 'package:pay_match/model/services/auth_service.dart';
import 'package:pay_match/model/services/firebase_service.dart';
import 'package:pay_match/model/services/sp_service.dart';

class ServiceManager{
  static Future<void> initialiseServices() async {
    await Prefs.instance().init();
    await FirebaseService.instance().init();
    //await AuthService.instance().init();
  }
}