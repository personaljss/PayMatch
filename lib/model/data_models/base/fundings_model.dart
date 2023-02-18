
import 'package:flutter/material.dart';

import '../trade/Orders.dart';



class Funding {
  final String symbol;
  final String fullName;
  final AssetImage img = AssetImage("logo.png");
  final AssetImage bgImg = AssetImage("a1bg.jpg");
  final RET_CODE retCode; //return code of a TradeRequest
  final int dealId; //id of the deal in case of a match of buyer and seller
  final double volumeRemaining; //lots bought or sold(this can be different from the volume requested because of market depth)
  final double price; //order execution price
  double fundedPercentage;


  Funding(this.symbol, this.fullName, this.retCode, this.dealId, this.volumeRemaining, this.price,this.fundedPercentage,);

  Funding.success(this.symbol, this.fullName, this.dealId, this.volumeRemaining, this.price,this.fundedPercentage) : retCode = RET_CODE.DONE;

  Funding.error(this.symbol, this.fullName, this.retCode)
      : dealId = 0,
        volumeRemaining = 0,
        price = 0,
        fundedPercentage = 0;

}