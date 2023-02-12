import 'package:flutter/material.dart';
import 'package:pay_match/model/observables/user_model.dart';
import 'package:provider/provider.dart';
import '../../model/data_models/base/Asset.dart';
import '../../utils/colors.dart';
import '../../utils/styles/text_styles.dart';

class StockCard extends StatelessWidget {
  StockCard({Key? key,required this.asset,required this.listName}) : super(key: key);
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
              Text(asset.fullName,
                  style: kSymbolNameTextStyle),
              const SizedBox(height: 8.0,),
              Text(asset.symbol,
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
              Text(asset.fullName,
                  style: kSymbolNameTextStyle),
              SizedBox(height: 8.0,),
              Text(asset.symbol,
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
              style: const TextStyle(
                color: Colors.green,
                letterSpacing: 1.3,
              ),
            )
                :
            Text(
              "-${(asset.percChange.toString())}%",
              style: TextStyle(
                color: Colors.red,
                letterSpacing: 1.3,
              ),
            )
        ),

        Expanded(flex:1,
          child: Text("₺ ${(asset.bid.toString())}",
            style: kPriceTextStyle,
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
    bool isFav = context.select<UserModel,bool>((model)=>model.lists[listName]!.contains(symbol));
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
