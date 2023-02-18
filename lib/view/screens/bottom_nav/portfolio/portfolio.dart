import 'package:flutter/material.dart';
import 'package:pay_match/constants/network_constants.dart';
import 'package:pay_match/model/data_models/base/Asset.dart';
import 'package:pay_match/model/observables/user_model.dart';
import 'package:pay_match/view/screens/bottom_nav/portfolio/tabs/transactions.dart';
import 'package:pay_match/view/screens/bottom_nav/portfolio/tabs/waiting_orders.dart';
import 'package:pay_match/view/screens/bottom_nav/portfolio/tabs/wallet.dart';
import 'package:pay_match/view/ui_tools/loading_screen.dart';
import 'package:provider/provider.dart';
import '../../../../utils/colors.dart';
import '../../../ui_tools/stock_card.dart';
import 'package:pay_match/model/data_models/trade/Orders.dart';


class PortfolioView extends StatelessWidget {
  PortfolioView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    NetworkState state=context.select<UserModel,NetworkState>((value) => value.portfolioState);
    return (state==NetworkState.DONE)? Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, isScrolled) => [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: const SliverSafeArea(
                      top: false,
                      sliver: SliverAppBar(
                        pinned: true,
                        floating: true,
                        snap: true,
                        title: Text("portföy"),
                        centerTitle: true,
                        bottom: TabBar(
                          indicatorColor: Colors.white,
                          indicatorWeight: 5,
                          tabs: [
                            Tab(
                              icon: Icon(Icons.wallet),
                              text: "cüzdan",
                            ),
                            Tab(
                              icon: Icon(Icons.watch_later_outlined),
                              text: "emirler",
                            ),
                            Tab(
                              icon: Icon(Icons.request_page),
                              text: "işlemler",
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
            body: TabBarView(
              children: [
                WalletPage(),
                OrdersPage(),
                TransactionsPage(),
              ],
            )),
      ),
    ) : const LoadingScreen();
  }

  Widget buildWalletPage() => SafeArea(
    top: false,
    bottom: false,
    child: Builder(
      builder: (context) {
        List<Asset> assets=context.select<UserModel,List<Asset>>((value)=>value.assets);
        return CustomScrollView(
        slivers: [
          SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20,10,20,10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Toplam Tutar"),
                      SizedBox(height: 4.0,),
                      Text("Toplam Kar/Zarar"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("8661.65 ₺"),
                      SizedBox(height: 4.0,),
                      Text("+55000.47 ₺"),
                    ],
                  )
                ],
              ),
            ),
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
                        child: WalletCard(asset: assets[index]),
                      ),
                      Divider(height: 1,
                        indent: 50.0,
                        endIndent: 50.0,
                        color: lightColorScheme.primaryContainer,
                      ),
                    ],
                  ),
                );
              }, childCount: assets.length
              ),
            ),
          ),
        ],
      );
      },
    ),
  );

  Widget buildOrdersPage(List<TradeResult> results) => SafeArea(
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

  Widget buildPage(String text) => SafeArea(
    top: false,
    bottom: false,
    child: Builder(
      builder: (context)=> CustomScrollView(slivers: [
            SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: buildCard(index),
                );
              }, childCount: 25)),
            )
          ]),
    ),
  );

  Widget buildCard(int index) => Card(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: Text("item$index"))),
      );
}
