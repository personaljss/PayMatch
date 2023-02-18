import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_match/model/data_models/base/Transaction.dart';

import '../../model/data_models/trade/Orders.dart';
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
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            flex: 3,
                            child: ((result.symbolName).length > 15)
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
