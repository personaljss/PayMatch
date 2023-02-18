import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_match/model/data_models/base/Transaction.dart';
import 'package:pay_match/model/observables/user_model.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/colors.dart';
import '../../../../ui_tools/order_card.dart';


class OrdersPage extends StatelessWidget {
  OrdersPage({Key? key}) : super(key: key);
  late List<Transaction> results ;
  @override
  Widget build(BuildContext context) {
    results=context.select<UserModel,List<Transaction>>((model)=>model.orders);
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
