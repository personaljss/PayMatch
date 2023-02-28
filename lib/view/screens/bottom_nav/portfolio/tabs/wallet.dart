import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../model/data_models/base/Asset.dart';
import '../../../../../model/observables/user_model.dart';
import '../../../../../utils/colors.dart';
import '../../../../ui_tools/stock_card.dart';
import '../../../../ui_tools/tiriviri.dart';
import '../../../../ui_tools/wallet_card.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (context) {
          List<Asset> assets=context.select<UserModel,List<Asset>>((value)=>value.assets);
          double equity=context.select<UserModel,double>((value) => value.equity);
          double balance=context.select<UserModel,double>((value) => value.balance);
          double profit=balance-equity;
          return (assets.isEmpty)?
          Scaffold(body:
          Column(children:[
            Padding(
              padding: EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Toplam Tutar"),
                      SizedBox(height: 4.0,),
                      Text("Toplam Kar/Zarar"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:  [
                      Text("$balance ₺"),
                      const SizedBox(height: 4.0,),
                      Text("$profit ₺"),
                    ],

                  ),
                ],
              ),
            ), const Padding(padding: EdgeInsets.all(30), child:Center(child: Text("henüz sahip olduğunuz bir pay yok")))
              ]
            ),
          ) :
           CustomScrollView(
            slivers: [
              SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
              /*
              AdaptiveHeightSliverPersistentHeader(
                floating: true,
                pinned: true,
                child: Padding(
                  //color: lightColorScheme.primaryContainer,
                  padding: EdgeInsets.fromLTRB(0,0,0,0),
                  child: Container(
                    color: lightColorScheme.primaryContainer,
                    child: Row(
                      //backgroundColor: lightColorScheme.primaryContainer,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex:5,
                            child: Text("")),
                        Expanded(flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Fiyat"),
                              ],
                            )),
                        const SizedBox(height: 4.0,),
                        Expanded( flex: 2,
                            child: Text("Pay")),
                        const SizedBox(height: 4.0,),
                        Expanded(flex: 3,
                            child: Text("Toplam")),

                      ],
                    ),
                  ),
                ),
              ),*/
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
                        children: const [
                          Text("Toplam Tutar"),
                          SizedBox(height: 4.0,),
                          Text("Toplam Kar/Zarar"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:  [
                          Text("$balance ₺"),
                          const SizedBox(height: 4.0,),
                          Text("$profit ₺"),
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
                            child: ExpandableWalletCard(
                                isExpanded: false,
                                expandedChild: WalletCard(asset: assets[index]),
                                collapsedChild: WalletCardNonExpanded(asset: assets[index])),
                            onTap: () => gotoTradeView(context,assets[index].symbol),
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
  }
}
