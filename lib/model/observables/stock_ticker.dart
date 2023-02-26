import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../firebase_options.dart';

class StockTicker {
  final StreamController<List<StockTick>> _tickController =
      StreamController<List<StockTick>>.broadcast();

  Stream<List<StockTick>> get stockTicks => _tickController.stream;

  StockTicker() {
    _listenServer();
  }

  void _listenServer() async{
    /*
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.getToken();
     */
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("stockTicker: ${message.data}");
      _emitTicks(_parseTicks(message));
    });
  }

  void _emitTicks(List<StockTick> ticks){
    _tickController.sink.add(ticks);
  }

  List<StockTick> _parseTicks(RemoteMessage message){
    List<StockTick> res=[];
    List ticks=jsonDecode(message.data[""]);
    ticks.forEach((element) {
      Map<String,dynamic> tick=jsonDecode(element);
      res.add(StockTick(symbol: tick["symbol"], ask: tick["buyprice"], bid: tick["sellprice"]));
    });
    return res;
  }

}

class StockTick {
  final String symbol;
  final double ask;
  final double bid;

  StockTick({required this.symbol, required this.ask, required this.bid});
}
