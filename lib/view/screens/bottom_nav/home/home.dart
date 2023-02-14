import 'package:flutter/material.dart';
import 'package:pay_match/constants/network_constants.dart';
import 'package:pay_match/model/observables/stocks_model.dart';
import 'package:pay_match/model/observables/user_model.dart';
import 'package:pay_match/utils/colors.dart';
import 'package:pay_match/view/screens/bottom_nav/home/search_delegate.dart';
import 'package:pay_match/view/screens/secondaries/trade.dart';
import 'package:pay_match/view/ui_tools/loading_screen.dart';
import 'package:pay_match/view/ui_tools/nav_drawer.dart';
import 'package:pay_match/view/ui_tools/stock_card.dart';
import 'package:provider/provider.dart';

import '../../../../model/data_models/base/Asset.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin{
  late TabController _tabController;
  late List<Asset> _assets;
  late List<String> _tabs=[UserModel.defaultList,];

  bool isSearchClicked=false;
  final Icon _searchIcon = const Icon(
    Icons.search,
  );

  final TextEditingController _filter = TextEditingController();


  @override
  void initState(){
    super.initState();
    _tabController=TabController(length: _tabs.length, vsync: this);
  }

  void _createList(String listname){
    _tabs.add(listname);
    _tabController=TabController(
        initialIndex: _tabController.index,
        length: _tabs.length,
        vsync: this);

    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    _tabs=context.select<UserModel, List<String>>((value) => value.lists.keys.toList());
    _assets=context.select<UserModel,List<Asset>>((value) => value.getAssetsInList(_tabs[_tabController.index]));
    NetworkState networkState=context.select<StocksModel,NetworkState>((value) => value.allState);
    if(_tabController.length!=_tabs.length){
      _tabController=TabController(
          initialIndex: _tabController.index,
          length: _tabs.length,
          vsync: this);
      setState(() {});
    }
    return(networkState==NetworkState.DONE)? Scaffold(
      drawer: const MyDrawer(),
      body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, isScrolled) => [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    pinned: true,
                    floating: true,
                    snap: true,
                    title: isSearchClicked? Container(
                      padding: const EdgeInsets.only(bottom: 2),
                      constraints: const BoxConstraints(minHeight: 40, maxHeight: 40),
                      width: 220,
                      child: TextField(
                        controller: _filter,
                        keyboardType: TextInputType.text,
                      ),
                    ): const Text("sayfam"),
                    centerTitle: true,
                    actions: [
                      IconButton(onPressed: ()=>showSearch(context: context, delegate: StockSearchDelegate(listName: _tabs[_tabController.index])), icon:_searchIcon,)
                      //IconButton(onPressed: ()=>_searchPressed(), icon:_searchIcon,),
                      /*
                      (_tabs.length>1 && _tabController.index>0)?IconButton(
                          onPressed: (){
                            Provider.of<UserModel>(context, listen: false).deleteShareGroup(_tabs[_tabController.index]);
                            _tabController.index=_tabController.index-1;
                          }, icon: const Icon(Icons.delete)):
                      const SizedBox(width: 0, height: 0,),

                       */
                    ],
                    bottom: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.white,
                      indicatorWeight: 5,
                      tabs: List.generate(_tabs.length, (index) => Tab(text: _tabs[index]))),
                    ),
                  ),
                ),
            ],
            body: TabBarView(
              controller: _tabController,
              children: List.generate(_tabs.length, (index) => buildFavPage(context.select<UserModel, List<Asset>>((value) => value.getAssetsInList(_tabs[index])),_tabs[index])),
            )
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { showDialog(context: context, builder: (BuildContext context)=>CreateListDialog(update: _createList,));},
        child: const Icon(Icons.add),
      ),
    ) :
    (networkState==NetworkState.LOADING)? const LoadingScreen() : const ErrorScreen();
  }

}

class CreateListDialog extends StatelessWidget {
  CreateListDialog({Key? key,required this.update}) : super(key: key);
  final ValueChanged<String> update;

  final TextEditingController _controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("yeni liste"),
      content: TextField(
        controller: _controller,
      ),
      actions: [
        TextButton(
            onPressed: (){
              Provider.of<UserModel>(context,listen: false).createShareGroup(_controller.text);
              update(_controller.text);
              Navigator.of(context).pop();
              },
            child: const Text("oluştur")),
        TextButton(
            onPressed: (){
              Navigator.of(context).pop();
              },
            child: const Text("iptal")),
      ],
    );
  }
}



Widget buildFavPage(List<Asset> assets, String listName) => SafeArea(
  top: false,
  bottom: false,
  child: Builder(
    builder: (context)=> CustomScrollView(slivers: [
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
                      onTap: () => gotoTradeView(context),
                      child: StockCard(asset: assets[index], listName: listName,),
                    ),
                    Divider(height: 1,
                      indent: 50.0,
                      endIndent: 50.0,
                      color: lightColorScheme.primaryContainer,
                    ),
                  ],
                ),
              );
            }, childCount: assets.length)),
      )
    ]),
  ),
);


void gotoTradeView(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TradeView()));
}