
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_match/model/data_models/base/Transaction.dart';
import '../../model/data_models/trade/Orders.dart';
import 'package:pay_match/view/ui_tools/tiriviri.dart';
import '../../utils/colors.dart';
import '../../utils/styles/text_styles.dart';

/*
class WaitingOrderCard extends StatelessWidget {
  final Transaction result;
  const WaitingOrderCard({Key? key,required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return buildWaitingOrderCard(context, result ,height);
  }
  Widget buildWaitingOrderCard(BuildContext context,Transaction result, double height) => Container(
    height: height * 0.20,
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
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: ClipOval(
                            child: Image.file(File(result.imgFileLoc),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(result.symbol,
                                    style: kSymbolNameTextStyle),
                              ),
                              //const SizedBox(height: 8.0,),
                              Expanded(
                                flex: 2,
                                child: Text((result.symbolName).length < 20 ? result.symbolName : "${result.symbolName.substring(0,20)}...",
                                  style: kSymbolTextStyle,),
                              ),
                              //const SizedBox(height: 8.0,),
                              Expanded(
                                  flex: 1,
                                  child: ((result.symbolName).length > 15)
                                      ?
                                  Text("AL",
                                    style: kChangeGreenTextStyle,
                                    textAlign: TextAlign.start,)
                                      :
                                  Text("SAT",
                                    style: kChangeRedTextStyle,
                                    textAlign: TextAlign.start,)
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /*
                  Expanded(
                      flex: 1,
                      child: ((result.symbolName).length > 15)
                          ?
                      Text("AL",
                        style: kChangeGreenTextStyle,
                        textAlign: TextAlign.start,)
                          :
                      Text("SAT",
                        style: kChangeRedTextStyle,
                        textAlign: TextAlign.start,)
                  ),*/

                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                              Text("${(result.amount)}₺", style: kOrderTextStyle,),
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
                              Text("${(result.amount * result.price)}₺", style: kOrderTextStyle,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 16.0,thickness: 1.5, indent: 10.0, endIndent: 10.0 ,color: lightColorScheme.inversePrimary,),
                  //SizedBox(height: 8.0,),
                  Expanded(
                    flex: 3,
                    child: Text(
                        formatDateTime(result.time)
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _showType(BuildContext ctx,TransType type){
    String txt="";
    TextStyle style=kChangeGreenTextStyle;
    switch(type){
      case TransType.buy:
        // TODO: Handle this case.
        txt="AL";
        style=kChangeGreenTextStyle;
        break;
      case TransType.sell:
        // TODO: Handle this case.
        txt="SAT";
        style=kChangeRedTextStyle;
        break;
      case TransType.buyLimit:
        // TODO: Handle this case.
        txt="AL";
        style=kChangeGreenTextStyle;
        break;
      case TransType.sellLimit:
        // TODO: Handle this case.
        txt="SAT";
        style=kChangeRedTextStyle;
        break;
    }
    return Text(txt,
      style: style,
      textAlign: TextAlign.center,);
  }
}

 */
class SimpleWaitingOrderCard extends StatelessWidget {
  Transaction result;
  SimpleWaitingOrderCard({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return buildSimpleWaitingOrderCard(context, result,  height, width);
  }
  Widget buildSimpleWaitingOrderCard(BuildContext context, Transaction result, double height, double width) => Container(
    height: height * 0.10,
    width: width,
    color: lightColorScheme.onSecondary,
    padding: EdgeInsets.fromLTRB(width * 0.03, height * 0.02, width * 0.03, height * 0.02),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text("${result.symbol}",
            textAlign: TextAlign.center,
            style: kSymbolTextStyle,
          ),
        ),
        Expanded(
          child: (result.symbolName).length > 15
              ? Text("AL",
            textAlign: TextAlign.center,
            style: kChangeGreenTextStyle,)
              : Text(
            ("SAT"),
            textAlign: TextAlign.center,
            style: kChangeRedTextStyle,),
        ),
        Expanded(
          child: Text("${result.remaining}",
            textAlign: TextAlign.center,
            style: kSymbolNameTextStyle,
          ),
        ),
        VerticalDivider(width: width * 0.003, thickness: width * 0.003, indent: (height * 0.02), endIndent: (height * 0.02), color: lightColorScheme.inversePrimary,),
        Expanded(
          child: Text("${result.amount}",
            textAlign: TextAlign.center,
            style: kSymbolNameTextStyle,
          ),
        ),
        VerticalDivider(width: width * 0.003, thickness: width * 0.003, indent: (height * 0.02), endIndent: (height * 0.02), color: lightColorScheme.inversePrimary,),
        Expanded(
          child: Text("${result.price}",
            textAlign: TextAlign.center,
            style: kSymbolNameTextStyle,
          ),
        ),
      ],
    ),
  );
}

class WaitingOrdersHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: lightColorScheme.primaryContainer,
      padding: EdgeInsets.fromLTRB(width * 0.03, height * 0.02, width * 0.03, height * 0.02),
      child: Row(
        //backgroundColor: lightColorScheme.primaryContainer,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 1,
            child: Text("Sembol",
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(flex: 1,
            child: Text("Emir",
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(flex: 1,
            child: Text("Kalan Pay",
              textAlign: TextAlign.center,
            ),
          ),
          //VerticalDivider(width: width * 0.1, thickness: width * 0.1,  color: Colors.black,),
          Expanded( flex: 1,
            child: Text("Miktar",
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(flex: 1,
            child: Text("Fiyat",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

