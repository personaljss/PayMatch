import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pay_match/model/observables/stock_ticker.dart';
import 'package:pay_match/model/observables/user_model.dart';
import 'package:pay_match/view/screens/secondaries/details.dart';
import 'package:provider/provider.dart';
import '../../model/data_models/base/Asset.dart';
import '../../utils/colors.dart';
import '../../utils/styles/text_styles.dart';
import '../screens/secondaries/trade.dart';

class StockCard extends StatelessWidget {
  const StockCard({Key? key, required this.asset, required this.listName})
      : super(key: key);
  final Asset asset;
  final String listName;
  @override
  Widget build(BuildContext context) =>
      StreamBuilder<StockTick>(
          stream: StockTicker().ticksOf(asset.symbol),
          builder: (BuildContext context, AsyncSnapshot<StockTick> snapshot) {
            double height = MediaQuery
                .of(context)
                .size
                .height;
            double width = MediaQuery
                .of(context)
                .size
                .width;
            if (snapshot.hasData) {
              try {
                asset.ask = snapshot.data!.ask;
                asset.bid = snapshot.data!.bid;
              } catch (e) {
                //
              }
            }
            return buildCard(context, asset, listName, height, width);
          });

  Widget buildCard(BuildContext context, Asset asset, String listName,
      double height, double width) =>
      GestureDetector(
        onTap: () {
          DetailsView.go(context, asset.symbol);
        },

        onLongPress:() => _onLongPressed(context,height,width),

        child: Card(
          margin: const EdgeInsets.all(0.0),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
          color: lightColorScheme.onSecondary,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(asset.symbol, style: kSymbolNameTextStyle),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        (asset.fullName).length < 20
                            ? asset.fullName
                            : "${asset.fullName.substring(0, 20)}...",
                        style: kSymbolTextStyle,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.26,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 8.0),
                    decoration: BoxDecoration(
                      color: asset.percChange > 0
                          ? Colors.green
                          : Colors.redAccent,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                          bottomLeft: Radius.circular(4.0),
                          bottomRight: Radius.circular(4.0)),
                      //border: Border.all(width: 8),
                    ),
                    child: Text(
                      asset.percChange > 0
                          ? "+${asset.percChange}%"
                          : "${asset.percChange}%",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [FavButton(symbol: asset.symbol, listName: listName)]
                    )
                )
              ],
            ),
          ),
        ),
      );

  _onLongPressed(BuildContext context, double height, double width)  async {
    /*
    if(!context.mounted){
      return;
    }

     */
    final RenderBox box;
    try{
      box = context.findRenderObject() as RenderBox;
    }catch(e){
      print("StockCard::_onnLongPress() $e");
      return;
    }
      final Offset position = box.localToGlobal(Offset.zero);
      final RelativeRect positionRelativeToScreen = RelativeRect.fromLTRB(
        //position.dx,
        height,
        position.dy,
        width - position.dx - box.size.width,
        height - position.dy - box.size.height,
      );
      showMenu(
        useRootNavigator: true,
        context: context,
        position: positionRelativeToScreen,
        items: <PopupMenuItem>[
          //PopupMenuItem(child: Text("listeden çıkar"),onTap: ()=> Provider.of<UserModel>(context, listen: false).deleteSymbolFromShareGroup(listName, asset.symbol)),
          PopupMenuItem(child: Text("detaylara git"), onTap: ()=>_goToDetails(context, asset.symbol)),
          PopupMenuItem(child: Text("alım-satım yap"), onTap: ()=>_goToTrade(context, asset.symbol),)
        ],
      );
  }

  _goToDetails(BuildContext context, String symbol) async {
    //Navigator.of(context).pop();
    await Future.delayed(const Duration(seconds: 0));
    DetailsView.go(context, asset.symbol);
  }

  _goToTrade(BuildContext context, String symbol) async {
    //Navigator.of(context).pop();
    await Future.delayed(const Duration(seconds: 0));
    TradeView.go(context, asset.symbol);
  }

}



class FavStockCard extends StatelessWidget {
  const FavStockCard({Key? key, required this.asset, required this.listName})
      : super(key: key);
  final Asset asset;
  final String listName;

  _goToDetails(BuildContext context, String symbol) async {
    //Navigator.of(context).pop();
    await Future.delayed(const Duration(seconds: 0));
    DetailsView.go(context, asset.symbol);
  }

  _goToTrade(BuildContext context, String symbol) async {
    //Navigator.of(context).pop();
    await Future.delayed(const Duration(seconds: 0));
    TradeView.go(context, asset.symbol);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return StreamBuilder<StockTick>(
        stream: StockTicker().ticksOf(asset.symbol),
        builder: (BuildContext context, AsyncSnapshot<StockTick> snapshot) {
          if (snapshot.hasData) {
            asset.ask = snapshot.data!.ask;
            asset.bid = snapshot.data!.bid;
          }
          return buildFavCard(context, asset, listName, height, width);
        });
  }

  Widget buildFavCard(BuildContext context, Asset asset, String listName,
      double height, double width) =>
      GestureDetector(
        onLongPress:() => _onLongPressed(context,height,width),
        onTap: () {
          DetailsView.go(context, asset.symbol);
        },
        child: Card(
          margin: const EdgeInsets.all(0.0),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
          color: lightColorScheme.onSecondary,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(asset.symbol, style: kSymbolNameTextStyle),
                      //const SizedBox(height: 8.0,),
                      //Text((asset.fullName).length < 20 ? asset.fullName : "${asset.fullName.substring(0,20)}...",
                      //style: kSymbolTextStyle,),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${asset.bid}",
                        style: kPriceTextStyle,
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        "${asset.ask}",
                        //style: kPriceMediumTextStyle,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.04,
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
                    decoration: BoxDecoration(
                      color: asset.percChange > 0
                          ? Colors.green
                          : Colors.redAccent,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                          bottomLeft: Radius.circular(4.0),
                          bottomRight: Radius.circular(4.0)),
                      //border: Border.all(width: 8),
                    ),
                    child: Text(
                      asset.percChange > 0
                          ? "+${asset.percChange}%"
                          : "${asset.percChange}%",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  _onLongPressed(BuildContext context, double height, double width)  async {
    /*
    if(!context.mounted){
      return;
    }

     */
    final RenderBox box;
    try{
      box = context.findRenderObject() as RenderBox;
    }catch(e){
      print("StockCard::_onnLongPress() $e");
      return;
    }
    final Offset position = box.localToGlobal(Offset.zero);
    final RelativeRect positionRelativeToScreen = RelativeRect.fromLTRB(
      //position.dx,
      height,
      position.dy,
      width - position.dx - box.size.width,
      height - position.dy - box.size.height,
    );
    showMenu(
      useRootNavigator: true,
      context: context,
      position: positionRelativeToScreen,
      items: <PopupMenuItem>[
        PopupMenuItem(child: Text("listeden çıkar"),onTap: ()=> Provider.of<UserModel>(context, listen: false).deleteSymbolFromShareGroup(listName, asset.symbol)),
        PopupMenuItem(child: Text("detaylara git"), onTap: ()=>_goToDetails(context, asset.symbol)),
        PopupMenuItem(child: Text("alım-satım yap"), onTap: ()=>_goToTrade(context, asset.symbol),)
      ],
    );
  }

}

class FavButton extends StatefulWidget {
  const FavButton({
    required this.symbol,
    required this.listName,
  });

  final String symbol;
  final String listName;

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton>
    with SingleTickerProviderStateMixin {
  late bool _isFav;
  bool _isClickable = true;
  late AnimationController _animationController;
  late Animation _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _colorAnimation =
        ColorTween(begin: Colors.grey[400], end: Colors.red).animate(
            _animationController);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _isClickable = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _isFav = Provider
        .of<UserModel>(context, listen: false)
        .lists[widget.listName]!
        .contains(widget.symbol);
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, _) =>
          IconButton(
            icon: Icon(Icons.favorite, color:(_isFav)? Colors.red:Colors.grey[400]),
            onPressed: () {
              if (!_isClickable) return;
              if (_isFav) {
                Provider.of<UserModel>(context, listen: false)
                    .deleteSymbolFromShareGroup(widget.listName, widget.symbol);
                _isFav = false;
                _animationController.reverse();
              } else {
                Provider.of<UserModel>(context, listen: false)
                    .addSymbolToShareGroup(widget.listName, widget.symbol);
                _isFav = true;
                _animationController.forward();
              }
              setState(() {

              });
            },
          ),
    );
  }
}
