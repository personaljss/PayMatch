import 'dart:io';

import 'package:flutter/material.dart';

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
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isExpanded = !widget.isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
        child: widget.isExpanded ? widget.expandedChild : widget.collapsedChild,
      ),
    );
  }
}

class WalletCard extends StatelessWidget {
  final Asset asset;
  const WalletCard({Key? key,required this.asset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return buildWalletCard(context, asset, height );
  }
  Widget buildWalletCard(BuildContext context,Asset asset,double height,) => Container(
    height: height * 0.45,
    width: double.infinity,
    child:   Card(
      margin: const EdgeInsets.all(0.0),
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
              padding: const EdgeInsets.all(6.0),
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
                  const SizedBox(width: 8.0,),
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
                  Text("${(asset.amountHold * asset.ask)} ₺",
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
                  Text("${(asset.amountHold)} Adet",
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
                  Text("${((asset.amountHold * asset.bid) - (asset.amountHold * asset.ask))} ₺",
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
                  Text("${((asset.amountHold * asset.bid) - (asset.amountHold * asset.ask)) / ((asset.amountHold * asset.ask)) * 100}",
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
}

class WalletCardNonExpanded extends StatelessWidget {
  final Asset asset;

  const WalletCardNonExpanded({Key? key,required this.asset,}) : super(key: key);
  //String listName;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Card(
      margin: const EdgeInsets.all(0.0),
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
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: lightColorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
                //border: Border.all(width: 8),
              ),
              child: Expanded(
                flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: ClipOval(
                        child: Image.file(File(asset.imgFileLoc),
                          width: 40.0,
                          height: 60.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0,),
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
            ),
          ],
        ),
      ),
    );
  }
}
