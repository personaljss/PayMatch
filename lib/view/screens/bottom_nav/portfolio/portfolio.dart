import 'package:flutter/material.dart';
import 'package:pay_match/constants/network_constants.dart';
import 'package:pay_match/model/observables/user_model.dart';
import 'package:pay_match/view/screens/bottom_nav/portfolio/tabs/transactions.dart';
import 'package:pay_match/view/screens/bottom_nav/portfolio/tabs/waiting_orders.dart';
import 'package:pay_match/view/screens/bottom_nav/portfolio/tabs/wallet.dart';
import 'package:pay_match/view/ui_tools/loading_screen.dart';
import 'package:pay_match/view/ui_tools/nav_drawer.dart';
import 'package:provider/provider.dart';

class PortfolioView extends StatelessWidget {
  const PortfolioView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NetworkState state = context.select<UserModel, NetworkState>((
        value) => value.portfolioState);
    return (state == NetworkState.DONE) ? Scaffold(
      drawer: const MyDrawer(),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, isScrolled) =>
            [
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
            body: const TabBarView(
              children: [
                WalletPage(),
                OrdersPage(),
                TransactionsPage(),
              ],
            )),
      ),
    ) : const LoadingScreen();
  }
}