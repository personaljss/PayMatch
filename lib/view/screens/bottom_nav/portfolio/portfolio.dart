import 'package:flutter/material.dart';

import '../../../../model/data_models/trade/Orders.dart';
import '../../../../utils/colors.dart';
import '../../../ui_tools/stock_card.dart';



class PortfolioView extends StatefulWidget {
  const PortfolioView({Key? key}) : super(key: key);

  @override
  State<PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {

//fake instance
  List<TradeResult> results = [
    TradeResult("AAPL", "Apple Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),
    TradeResult("AAPL", "Apple Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),
    TradeResult("AAPL", "Apple Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),
    TradeResult("AAPL", "Apple Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),
    TradeResult("AAPL", "Apple Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),
    TradeResult("AAPL", "Apple Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),
    
  ];
  List<TradeResult> results2 = [
    TradeResult("AMZN", "Amazon Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),
    TradeResult("EXXN", "Exxon Mobile Oil Company Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),
    TradeResult("TMNT", "Teenage Mutant Ninja Turtles Incorporated.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),
    TradeResult("AAPL", "Apple Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),
    TradeResult("AAPL", "Apple Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),
    TradeResult("AAPL", "Apple Inc.", RET_CODE.PLACED, 0, 150, 345.30, 345.31, 345.30),

  ];
  String listName = "FakeName";
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                buildWalletPage(results2, listName),
                buildOrdersPage(results, listName),
                buildOrdersPage(results2, listName),
              ],
            )),
      ),
    );
  }
  Widget buildWalletPage(List<TradeResult> results, String listName) => SafeArea(
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
                        child: WalletCard(result: results[index], listName: listName,),
                      ),
                      Divider(height: 1,
                        indent: 50.0,
                        endIndent: 50.0,
                        color: lightColorScheme.primaryContainer,
                      ),
                    ],
                  ),
                );
              }, childCount: results.length
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget buildOrdersPage(List<TradeResult> results, String listName) => SafeArea(
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
                            child: WaitingOrderCard(result: results[index], listName: listName,),
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
