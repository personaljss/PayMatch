import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../model/data_models/trade/Orders.dart';
import '../../../../../utils/colors.dart';
import '../../../../ui_tools/stock_card.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({Key? key}) : super(key: key);
  final List<TradeResult> results = [
    TradeResult("AAPL", "Apple Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),
    TradeResult("AAPL", "Apple Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),
    TradeResult("AAPL", "Apple Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),
    TradeResult("AAPL", "Apple Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),
    TradeResult("AAPL", "Apple Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),
    TradeResult("AAPL", "Apple Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),

  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (context) => CustomScrollView(
            slivers: [
              SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
              SliverPadding(
                padding: const EdgeInsets.all(0),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        //margin: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          children: [
                            GestureDetector(
                              //onTap: () => gotoTradeView(context),
                              child: WaitingOrderCard(result: results[index]),
                            ),
                            Divider(height: 0.5,
                              indent: 50.0,
                              endIndent: 50.0,
                              color: lightColorScheme.primaryContainer,
                            ),
                          ],
                        ),
                      );
                    }, childCount: results.length)),
              )
            ]
        ),
      ),
    );
  }
}
