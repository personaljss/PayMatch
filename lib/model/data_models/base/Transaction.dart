


class Transaction{
  final BigInt id;
  final String symbol;
  final double amount;
  double remaining;
  final double price;
  final int expiration;
  final int time;
  final TransStatus status;
  final TransType transType;
  final double avgPrice;
  late String symbolName;
  late String imgFileLoc;

  Transaction({required this.id, required this.symbol, required this.amount, required this.remaining,
      required this.price, required this.expiration, required this.status,required this.transType,required this.time,required this.avgPrice});

  static List<Transaction> sortTimes(List<Transaction> transactions) {
    if (transactions.length <= 1) {
      return transactions;
    }

    int middleIndex = transactions.length ~/ 2;
    List<Transaction> leftList = transactions.sublist(0, middleIndex);
    List<Transaction> rightList = transactions.sublist(middleIndex);

    leftList = sortTimes(leftList);
    rightList = sortTimes(rightList);

    return _merge(leftList, rightList);
  }

  factory Transaction.fromJson(Map<String, dynamic> json, Map<String,String> symbolsMap,TransType type){
    Transaction ts = Transaction(
        id: BigInt.parse(json["tid"]),
        symbol: json["symbol"],
        amount: double .parse(json["amount"]),
        remaining: double.parse(json["remaining"]),
        price: double.parse(json["price"]),
        expiration: int.parse(json["ts"]),
        status: TransStatus.success,
        transType: type,
        time: int.parse(json["startts"]),
        avgPrice: double.parse(json["avgprice"]));
    try{
      ts.symbolName=symbolsMap[json["symbol"]]!;
    }catch(e){
      print(e);
    }

    return ts;
  }

  static List<Transaction> _merge(List<Transaction> leftList, List<Transaction> rightList) {
    List<Transaction> mergedList = [];

    int leftIndex = 0;
    int rightIndex = 0;

    while (leftIndex < leftList.length && rightIndex < rightList.length) {
      if (leftList[leftIndex].time > rightList[rightIndex].time) {
        mergedList.add(leftList[leftIndex]);
        leftIndex++;
      } else {
        mergedList.add(rightList[rightIndex]);
        rightIndex++;
      }
    }

    while (leftIndex < leftList.length) {
      mergedList.add(leftList[leftIndex]);
      leftIndex++;
    }

    while (rightIndex < rightList.length) {
      mergedList.add(rightList[rightIndex]);
      rightIndex++;
    }

    return mergedList;
  }



}
//0: transaction iptal edilmiş
// 1: transaction bütün lotlar satıldığı için bitmiş
// 2: zaman dolduğu için bitmiş
// 3: para yetmediği için bitmiş (denk gelme ihtimali yok gibi bir şey)
enum TransStatus{
  canceled,
  success,
  expired,
  noMoney,
}

enum TransType{
  buy,
  sell,
  buyLimit,
  sellLimit
}

enum TradeResponse{
  success,
  failure,
  systemError,
  noMoney
}