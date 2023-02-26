import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_match/model/data_models/base/Transaction.dart';
import 'package:pay_match/view/ui_tools/tiriviri.dart';
import '../../utils/colors.dart';
import '../../utils/styles/text_styles.dart';

class WaitingOrderCard extends StatelessWidget {
  Transaction result;
  WaitingOrderCard({Key? key,required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return buildWaitingOrderCard(context, result ,height);
  }
  Widget buildWaitingOrderCard(BuildContext context,Transaction result, double height) => Container(
    height: height * 0.25 ,
    child:   Card(
      margin: const EdgeInsets.all(0.0),
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
                  Text((result.symbolName).length < 20 ? result.symbolName : "${result.symbolName.substring(0,20)}...",
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
                  Divider(height: 16.0,thickness: 1.5, indent: 10.0, endIndent: 10.0 ,color: lightColorScheme.inversePrimary,),
                  //SizedBox(height: 8.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          flex: 3,
                          child: _showType(context, result.transType)
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                            formatDateTime(result.time)
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
