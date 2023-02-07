import 'package:flutter/material.dart';



class PortfolioView extends StatefulWidget {
  const PortfolioView({Key? key}) : super(key: key);

  @override
  State<PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {
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
                buildPage("cüzdan"),
                buildPage("emirler"),
                buildPage("işlemler")
              ],
            )),
      ),
    );
  }

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
