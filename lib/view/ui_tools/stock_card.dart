import 'package:flutter/material.dart';
import 'package:pay_match/model/data_models/trade/Orders.dart';
import 'package:pay_match/model/observables/user_model.dart';
import 'package:provider/provider.dart';
import '../../model/data_models/base/Asset.dart';
import '../../model/data_models/base/fundings_model.dart';
import '../../utils/colors.dart';
import '../../utils/styles/text_styles.dart';


//TODO::implement row column main axis
class StockCard extends StatelessWidget {
  StockCard({Key? key, required this.asset, required this.listName})
      : super(key: key);
  Asset asset;
  String listName;

  @override
  Widget build(BuildContext context) {
    return buildCard(context, asset, listName);
  }
}

class FavStockCard extends StatelessWidget {
  FavStockCard({Key? key,required this.asset,required this.listName}) : super(key: key);
  Asset asset;
  String listName;

  @override
  Widget build(BuildContext context) {
    return buildFavCard(context, asset, listName);
  }
}


class WaitingOrderCard extends StatelessWidget {
  TradeResult result;
  WaitingOrderCard({Key? key,required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return buildWaitingOrderCard(context, result ,height);
  }
}


class WalletCard extends StatelessWidget {
  Asset asset;
  void setCompanyName(){
  }

  WalletCard({Key? key,required this.asset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return buildWalletCard(context, asset, height );
  }
}


class FundingsCard extends StatelessWidget {
  Funding funding;


  FundingsCard({Key? key,required this.funding});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return buildFundingsCard(context, funding, height);
  }
}

Widget buildFundingsCard(BuildContext context, Funding funding, double height) => Container(
  height: height * 0.65,
  child:   Card(
    margin: EdgeInsets.all(0.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
    color: lightColorScheme.onPrimary,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: funding.bgImg,
                        fit: BoxFit.fill,
                        opacity: 0.3,
                        isAntiAlias: true,
                      ),
                    ),
                    child: Text("A1 Capital",
                      style: kPriceTextStyle,)),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);


//chamged price to bid need change ASAP
Widget buildWalletCard(BuildContext context,Asset asset,double height,) => Container(
  height: height * 0.45,
  width: double.infinity,
  child:   Card(
    margin: EdgeInsets.all(0.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
    color: lightColorScheme.onPrimary,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //StockHeader
          Container(
            //width: ,
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: lightColorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
              //border: Border.all(width: 8),
            ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ClipOval(
                      child: Image.network("https://play-lh.googleusercontent.com/8MCdyr0eVIcg8YVZsrVS_62JvDihfCB9qERUmr-G_GleJI-Fib6pLoFCuYsGNBtAk3c",
                        width: 40.0,
                        height: 60.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0,),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(asset.symbol,
                            style: kSymbolNameTextStyle),
                        const SizedBox(height: 8.0,),
                        Text((asset.fullName).length < 20 ? asset.fullName : "${asset.fullName.substring(0,20)}...",
                          style: kSymbolTextStyle,),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          //const SizedBox(width: 16.0,),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Toplam Tutar",
                  style: kSymbolNameTextStyle,
                ),
                const SizedBox(width: 8.0,),
                Text("${(asset.amount * asset.ask)} ₺",
                  style: kPriceTextStyle,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Pay Miktarım",
                  style: kSymbolNameTextStyle,
                ),
                const SizedBox(width: 8.0,),
                Text("${(asset.amount)} Adet",
                  style: kPriceTextStyle,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Son Fiyat",
                  style: kSymbolNameTextStyle,
                ),
                const SizedBox(width: 8.0,),
                Text("${(asset.ask)} ₺",
                  style: kPriceTextStyle,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Maliyet",
                  style: kSymbolNameTextStyle,
                ),
                const SizedBox(width: 8.0,),
                Text("${(asset.bid)} ₺",
                  style: kPriceTextStyle,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Kar/Zarar",
                  style: kSymbolNameTextStyle,
                ),
                const SizedBox(width: 8.0,),
                Text("${((asset.amount * asset.bid) - (asset.amount * asset.ask))} ₺",
                  style: kPriceTextStyle,),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Getiri",
                  style: kSymbolNameTextStyle,
                ),
                const SizedBox(width: 8.0,),
                Text("${((asset.amount * asset.bid) - (asset.amount * asset.ask)) / ((asset.amount * asset.ask)) * 100}",
                  style: kPriceTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);

Widget buildWaitingOrderCard(BuildContext context,TradeResult result, double height) => Container(
  height: height * 0.18 ,
  child:   Card(
    margin: EdgeInsets.all(0.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
    color: lightColorScheme.onSecondary,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: ClipOval(
              child: Image.network("https://play-lh.googleusercontent.com/8MCdyr0eVIcg8YVZsrVS_62JvDihfCB9qERUmr-G_GleJI-Fib6pLoFCuYsGNBtAk3c",
                width: 60.0,
                height: 60.0,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 16.0,),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(result.symbol,
                    style: kSymbolNameTextStyle),
                const SizedBox(height: 8.0,),
                Text((result.fullName).length < 20 ? result.fullName : "${result.fullName.substring(0,20)}...",
                  style: kSymbolTextStyle,),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Fiyat",
                            style: kSymbolNameTextStyle,
                          ),
                          Divider(height: 16.0, thickness: 1.5, indent: 10.0, endIndent: 10.0, color: lightColorScheme.inversePrimary,),
                          Text("${(result.price)}₺", style: kOrderTextStyle,),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Pay",
                            style: kSymbolNameTextStyle,
                          ),
                          Divider(height: 16.0, thickness: 1.5, indent: 10.0, endIndent: 10.0, color: lightColorScheme.inversePrimary,),
                          Text("${(result.volume)}₺", style: kOrderTextStyle,),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Toplam",
                            style: kSymbolNameTextStyle,
                          ),
                          Divider(height: 16.0, thickness: 1.5, indent: 10.0, endIndent: 10.0, color: lightColorScheme.inversePrimary,),
                          Text("${(result.volume * result.price)}₺", style: kOrderTextStyle,),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(height: 16.0,thickness: 1.5, indent: 10.0, endIndent: 10.0 ,color: lightColorScheme.inversePrimary,),
                //SizedBox(height: 8.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ((result.fullName).length > 15)
                        ?
                        Text("AL",
                        style: kChangeGreenTextStyle,
                        textAlign: TextAlign.center,)
                        :
                        Text("SAT",
                        style: kChangeRedTextStyle,
                        textAlign: TextAlign.center,)
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                          "02.04.2001 -> 31.05.2001"
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);



Widget buildFavCard(BuildContext context,Asset asset, String listName) => Card(
  margin: EdgeInsets.all(0.0),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
  color: lightColorScheme.onSecondary,
  child: Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: ClipOval(
            child: Image.network("https://play-lh.googleusercontent.com/8MCdyr0eVIcg8YVZsrVS_62JvDihfCB9qERUmr-G_GleJI-Fib6pLoFCuYsGNBtAk3c",
              width: 60.0,
              height: 60.0,
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(width: 16.0,),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(asset.symbol,
                  style: kSymbolNameTextStyle),
              const SizedBox(height: 8.0,),
              Text((asset.fullName).length < 20 ? asset.fullName : "${asset.fullName.substring(0,20)}...",
                style: kSymbolTextStyle,),

            ],
          ),
        ),
        Expanded(flex: 1,
          child: Text(asset.sector), ),
        /*Expanded(
                flex: 1,
                child: Text(
                  asset.percChange.toString(),
                  style: TextStyle(
                      color:
                          (asset.percChange > 0) ? Colors.green : Colors.red),
                ),
              ),*/
        /*Expanded(flex:1,
                  child: Text(asset.bid.toString())),*/
        Expanded(flex: 1,
            child: _FavButton(
              symbol: asset.symbol,
              listName: listName,
            ))
      ],
    ),
  ),
);


Widget buildCard(BuildContext context,Asset asset,String listName) => Card(
  margin: const EdgeInsets.all(0.0),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
  color: lightColorScheme.onSecondary,
  child: Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: ClipOval(
            child: Image.network("https://play-lh.googleusercontent.com/8MCdyr0eVIcg8YVZsrVS_62JvDihfCB9qERUmr-G_GleJI-Fib6pLoFCuYsGNBtAk3c",
              width: 60.0,
              height: 60.0,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(width: 16.0,),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(asset.symbol,
                  style: kSymbolNameTextStyle),
              SizedBox(height: 8.0,),
              Text((asset.fullName).length < 20 ? asset.fullName : "${asset.fullName.substring(0,20)}...",
                style: kSymbolTextStyle,),
            ],
          ),
        ),
        Expanded(
            flex: 1,
            child:
            (asset.percChange > 0)
                ?
            Text(
              "+${(asset.percChange.toString())}%",
              style: kChangeGreenTextStyle
            )
                :
            Text(
              "-${(asset.percChange.toString())}%",
              style: kChangeRedTextStyle
            )
        ),
        SizedBox(height: 8.0,),

        Expanded(flex:1,
          child: Text("₺ ${(asset.bid.toString())}",
            style: kPriceTextStyle,
          ),
        ),
        Expanded(flex: 1,
            child: _FavButton(
              symbol: asset.symbol,
              listName: listName,
            ),
        ),
      ],
    ),
  ),
);

class _FavButton extends StatelessWidget {
   const _FavButton({required this.symbol, required this.listName,});
  final String symbol;
  final String listName;
  @override
  Widget build(BuildContext context) {
    bool isFav=Provider.of<UserModel>(context,listen: false).lists[listName]!.contains(symbol);
    //bool isFav = context.select<UserModel,bool>((model)=>model.lists[listName]!.contains(symbol));
    return IconButton(
        onPressed: () {
          if (isFav) {
            Provider.of<UserModel>(context, listen: false).deleteSymbolFromShareGroup(listName, symbol);
          } else {
            Provider.of<UserModel>(context, listen: false).addSymbolToShareGroup(listName, symbol);
          }
        },
        icon: (isFav) ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline_sharp));
  }
}
