import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pay_match/view/screens/secondaries/details.dart';

import '../../model/data_models/base/Asset.dart';
import '../../utils/colors.dart';
import '../../utils/styles/text_styles.dart';


class ExpandableWalletCard extends StatefulWidget {
  bool isExpanded;
  final Widget collapsedChild;
  final Widget expandedChild;

  ExpandableWalletCard(
      { Key? key, required this.isExpanded, required this.collapsedChild, required this.expandedChild})
      : super(key: key);

  @override
  State<ExpandableWalletCard> createState() =>
      _ExpandableWalletCardState();


}

class _ExpandableWalletCardState extends State<ExpandableWalletCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isExpanded = !widget.isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: new Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
        child: widget.isExpanded
          ? Container(
            height: height * 0.62,
            child: Column(
              children: [
                Container(
                  height: height * 0.12,
                  child: widget.collapsedChild,
                ),
                Container(
                    height: height * 0.45,
                    child: widget.expandedChild
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.isExpanded = !(widget.isExpanded);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    height: height * 0.05,
                    color: lightColorScheme.onPrimary,
                    child: Center(
                      child: Icon(Icons.arrow_drop_up),
                    ),
                  ),
                ),
              ],
            ),
          )
          : Container(
            height: height * 0.15,
            child: Column(
              children: [
                Container(
                    height: height * 0.12,
                    child: widget.collapsedChild
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.isExpanded = !(widget.isExpanded);
                    });
                  },
                  child: Container(
                    //margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    height: height * 0.03,
                    color: lightColorScheme.onPrimary,
                    child: Center(
                      child: Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



//uses TradeResult and listName
//change to asset and delete listName from here and from buildWalletCard2
class WalletCard extends StatelessWidget {
  Asset result;

  WalletCard({Key? key,required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return buildWalletCard(context, result, height);
  }

  Widget buildWalletCard(BuildContext context,Asset result, height) => Container(
    height: height * 0.45,
    //width: double.infinity,
    color:lightColorScheme.onPrimary,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //StockHeader
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
                Text("${(result.amountHold * result.ask).toStringAsFixed(2)} ₺",
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
                Text("${(result.amountHold.toStringAsFixed(2))}",
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
                Text("${(result.ask).toStringAsFixed(2)} ₺",
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
                Text("${result.cost.toStringAsFixed(2)} ₺",
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
                Text("${result.profit.toStringAsFixed(2)} ₺",
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
                Text("${(result.profit/result.cost*100).toStringAsFixed(2)} ₺",
                  style: kPriceTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}




//uses TradeResult and listName
//change to asset and delete listName from here and from buildWalletCard2
class WalletCardNonExpanded extends StatelessWidget {
  Asset result;

  WalletCardNonExpanded({Key? key,required this.result}) : super(key: key);

  void _goToDetails(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>DetailsView(symbol: result.symbol,)));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.10,
      color: lightColorScheme.onPrimary,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: lightColorScheme.primaryContainer,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0)),
              //border: Border.all(width: 8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: ClipOval(
                    child: Image.network(result.imgFileLoc,
                      width: 40.0,
                      height: 60.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: 8.0,),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(result.symbol,
                          style: kSymbolNameTextStyle),
                      const SizedBox(height: 8.0,),
                      Text((result.fullName).length < 20 ? result.fullName : "${result.fullName.substring(0,20)}...",
                        style: kSymbolTextStyle,),
                    ],
                  ),
                ),
                Expanded(flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.info_outline_rounded),
                    onPressed: () {
                      _goToDetails(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
