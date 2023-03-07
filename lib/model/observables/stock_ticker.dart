import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class StockTicker {
  final StreamController<List<StockTick>> _tickController =
  StreamController<List<StockTick>>.broadcast();

  ///list of all ticks data, now it is not meant to be used by ui
  Stream<List<StockTick>> get stockTicks => _tickController.stream;

  ///this function is used by a StreamBuilder in cards to reflect price changes.
  Stream<StockTick> ticksOf(String symbol) =>
      stockTicks.map<StockTick>((ticks) =>
          ticks.firstWhere((element) => element.symbol==symbol
          )
      );

  StockTicker._privateConstructor(){
    print("StockTicker created!!!");
    _listenServer();
  }

  static final StockTicker _instance = StockTicker._privateConstructor();

  factory StockTicker() {
    return _instance;
  }

  void _listenServer() async {
    if (Firebase.apps.isNotEmpty) {
      print("listenServer()");
      FirebaseMessaging.onMessage.asBroadcastStream().listen((RemoteMessage message) {
        //print("stockTicker: ${message.data}");
        _emitTicks(_parseTicks(message));
      });
    }
  }

  void _emitTicks(List<StockTick> ticks) {
    _tickController.sink.add(ticks);
  }

  List<StockTick> _parseTicks(RemoteMessage message) {
    List<StockTick> res = [];
    List ticks = jsonDecode(message.data["data"]);
    ticks.forEach((element) {
      var tick = element;
      //Map<String,dynamic> tick=jsonDecode(element);
      res.add(StockTick(symbol: tick["symbol"], ask: double.parse(tick["buyprice"]), bid: double.parse(tick["sellprice"])));
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
