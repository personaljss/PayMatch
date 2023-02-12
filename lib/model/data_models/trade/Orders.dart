enum ORDER_TYPE {
  BUY_LIMIT,
  SELL_LIMIT,
  MODIFY,
  CANCEL
}

enum RET_CODE {
  PLACED, //order placed successfully
  DONE, //deal
  PARTIALLY_DONE, //deal is done but there are some remaining lots
  CANCELED, //order canceled for some reason
  TIMEOUT, //order canceled because of time-out(we are ahead of expiration date)
  TIMEOUT_MARKET, //order canceled because of market's order execution time limitation
  INVALID, //request is invalid for some reason
  INVALID_VOLUME, //request is invalid because of invalid volume(there can be some limitations about volume traded)
  INVALID_PRICE, //request is invalid because of invalid price(there can be some limitations or illogical prices like -1 tl)
  INVALID_STOPS, //buy orders' stop loss cannot be above price and sell orders' stop loss cannot be below price
  INVALID_EXPIRATION, //expiration date is invalid
  TRADE_DISABLED, //trading is disabled now for some reason
  MARKET_CLOSED, //market is closed now
  NO_MONEY, //user does not have enough balance to perform this trade
  NO_ASSET, //user does not have enough asset to sell
  NO_QUOTE, //the asset is not listed in the server for any reason
  LONG_ONLY, //You cannot sell this asset now, only longs permitted
}

class TradeRequest {
  final String symbol; //name of the asset
  final double price; //order price
  final double volume; //lots to be bought or sold
  final ORDER_TYPE orderType; //buy, sell, modify or cancel
  final double tp; //take profit(a limit order opposite of existing one)
  final double sl; //stop loss(a limit order opposite of existing one)
  final int expiration; //the expiration time of the order
  final int accountId; //the account id
  final int orderId; //to modify or cancel an existing order

  TradeRequest(this.symbol,
      this.price,
      this.volume,
      this.orderType,
      this.tp,
      this.sl,
      this.expiration,
      this.accountId,
      this.orderId);
}

class TradeResult {
  final String symbol;
  final String fullName;
  final RET_CODE retCode; //return code of a TradeRequest
  final int dealId; //id of the deal in case of a match of buyer and seller
  final double volume; //lots bought or sold(this can be different from the volume requested because of market depth)
  final double price; //order execution price
  final double bid; //best price offered by a buyer(buy order with highest price)
  final double ask; //best price offered by a seller(sell order with lowest price )

  TradeResult(this.symbol, this.fullName, this.retCode, this.dealId, this.volume, this.price, this.bid,
      this.ask);

  TradeResult.success(this.symbol, this.fullName, this.dealId, this.volume, this.price, this.bid,
      this.ask) : retCode = RET_CODE.DONE;

  TradeResult.error(this.symbol, this.fullName, this.retCode)
      : dealId = 0,
        volume = 0,
        price = 0,
        bid = 0,
        ask = 0;
}

