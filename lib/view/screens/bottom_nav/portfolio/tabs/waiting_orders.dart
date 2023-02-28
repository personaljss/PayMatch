import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_match/model/data_models/base/Transaction.dart';
import 'package:pay_match/model/observables/user_model.dart';
import 'package:persistent_header_adaptive/adaptive_height_sliver_persistent_header.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/colors.dart';
import '../../../../ui_tools/order_card.dart';
import '../../../../ui_tools/tiriviri.dart';


class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Transaction> results=context.select<UserModel,List<Transaction>>((model)=>model.orders);
    return (results.isNotEmpty)? SafeArea(
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
                              onTap: () => gotoTradeView(context,results[index].symbol),
                              child: ExpandableWaitingOrderCard(expandedChild: WaitingOrderCard(result: results[index]), collapsedChild: WaitingOrderCardCollapsed(result: results[index])),
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
    ):const Center(child: Text("henüz bir alım-satım emriniz yok"));
  }
}
