import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pay_match/model/data_models/trade/Orders.dart';
import 'package:pay_match/model/observables/stock_ticker.dart';
import 'package:pay_match/model/observables/user_model.dart';
import 'package:pay_match/view/screens/secondaries/details.dart';
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
  Widget build(BuildContext context) => StreamBuilder<StockTick>(
      stream: StockTicker().ticksOf(asset.symbol),
      builder: (BuildContext context, AsyncSnapshot<StockTick> snapshot){
        if(snapshot.hasData){
          asset.ask=snapshot.data!.ask;
          asset.bid=snapshot.data!.bid;
        }
        return buildCard(context, asset, listName);
      });

  Widget buildCard(BuildContext context,Asset asset,String listName)  => GestureDetector(
    onTap: (){
      DetailsView.go(context, asset.symbol);
    },
    child: Card(
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
                child: Image.network(asset.imgFileLoc,
                ),
              ),
            ),
            const SizedBox(width: 16.0,),
            Expanded(
              flex: 2,
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
            Expanded(flex:2,

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
    ),
  );
}

class FavStockCard extends StatelessWidget {
  const FavStockCard({Key? key,required this.asset,required this.listName}) : super(key: key);
  final Asset asset;
  final String listName;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<StockTick>(
        stream: StockTicker().ticksOf(asset.symbol),
        builder: (BuildContext context, AsyncSnapshot<StockTick> snapshot){
          if(snapshot.hasData){
            asset.ask=snapshot.data!.ask;
            asset.bid=snapshot.data!.bid;
          }
          return buildFavCard(context, asset, listName,height,width);
        });
  }

  Widget buildFavCard(BuildContext context,Asset asset, String listName, double height, double width) => GestureDetector(
    onTap: (){
      DetailsView.go(context, asset.symbol);
    },

    child: Card(
      margin: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      color: lightColorScheme.onSecondary,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            /*Expanded(
              flex: 2,
              child: ClipOval(
                child: Image.asset("assets/logo.png",
                  width: 20.0,
                  height: 40.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),*/
            //SizedBox(width: width * 0.03,),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(asset.symbol,
                      style: kSymbolNameTextStyle),
                  //const SizedBox(height: 8.0,),
                  //Text((asset.fullName).length < 20 ? asset.fullName : "${asset.fullName.substring(0,20)}...",
                  //style: kSymbolTextStyle,),
                ],
              ),
            ),
            Expanded(flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("${asset.bid}",
                    style: kPriceTextStyle,
                    textAlign: TextAlign.end,
                  ),
                  Text("${asset.ask}",
                    //style: kPriceMediumTextStyle,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
            SizedBox(width: width * 0.04,),
            Expanded(flex: 3,
              child: Container(
                padding: EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
                decoration: BoxDecoration(
                  color: asset.percChange > 0
                      ? Colors.green
                      : Colors.redAccent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                      bottomLeft: Radius.circular(4.0),
                      bottomRight: Radius.circular(4.0)
                  ),
                  //border: Border.all(width: 8),
                ),
                child: Text(
                  asset.percChange > 0
                      ? "+${asset.percChange}%"
                      : "${asset.percChange}%",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
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
            /*Expanded(flex: 1,
                child: _FavButton(
                  symbol: asset.symbol,
                  listName: listName,
                ),),*/
          ],
        ),
      ),
    ),
  );

}

class _FavButton extends StatefulWidget {
  const _FavButton({required this.symbol, required this.listName,});
  final String symbol;
  final String listName;

  @override
  State<_FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<_FavButton> {
  @override
  Widget build(BuildContext context) {
    bool isFav=Provider.of<UserModel>(context,listen: false).lists[widget.listName]!.contains(widget.symbol);
    //bool isFav = context.select<UserModel,bool>((model)=>model.lists[listName]!.contains(symbol));
    return IconButton(
        onPressed: () {
          if (isFav) {
            Provider.of<UserModel>(context, listen: false).deleteSymbolFromShareGroup(widget.listName, widget.symbol);
            setState(() {
              isFav=false;
            });
          } else {
            Provider.of<UserModel>(context, listen: false).addSymbolToShareGroup(widget.listName, widget.symbol);
            setState(() {
              isFav=true;
            });
          }
        },
        icon: (isFav) ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline_sharp));
  }
}
