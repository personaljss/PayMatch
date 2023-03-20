import 'package:flutter/material.dart';
import 'package:persistent_header_adaptive/adaptive_height_sliver_persistent_header.dart';
import 'package:provider/provider.dart';
import '../../../../../model/data_models/base/Transaction.dart';
import '../../../../../model/observables/user_model.dart';
import '../../../../../utils/colors.dart';
import '../../../../ui_tools/order_card.dart';
import '../../../../ui_tools/tiriviri.dart';


class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Transaction> results=context.select<UserModel,List<Transaction>>((model) => model.deals);
    return (results.isNotEmpty)? buildOrdersPage(results): const Center(child: Text("henüz yapmış olduğunuz bir işlem yok"));
  }
  Widget buildOrdersPage(List<Transaction> results) => SafeArea(
    top: false,
    bottom: false,
    child: Builder(
      builder: (context) => CustomScrollView(slivers: [
        SliverOverlapInjector(
            handle:
            NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
        // ADD persistent_header_adaptive: ^1.0.0 to pubspec.yaml
        AdaptiveHeightSliverPersistentHeader(
          floating: true,
          pinned: true,
          child: WaitingOrdersHeader(),
        ),
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
                          child: SimpleWaitingOrderCard(
                            result: results[index],
                          )),
                      Divider(
                        height: 1,
                        indent: 50.0,
                        endIndent: 50.0,
                        color: lightColorScheme.primaryContainer,
                      ),
                    ],
                  ),
                );
              }, childCount: results.length)),
        )
      ]),
    ),
  );
}
