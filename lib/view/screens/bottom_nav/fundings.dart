import 'package:flutter/material.dart';

import '../../../model/data_models/base/fundings_model.dart';
import '../../../model/data_models/trade/Orders.dart';
import '../../../utils/colors.dart';
import '../../ui_tools/nav_drawer.dart';
import '../../ui_tools/stock_card.dart';

class FundingsView extends StatelessWidget {
  FundingsView({Key? key}) : super(key: key);

  List<Funding> fundingsList = [
    Funding("AAPL", "Apple Inc.", RET_CODE.PLACED, 0, 15000, 345.30, 0.1),
    Funding("AMZN", "Amazon Inc.", RET_CODE.PLACED, 0, 15000, 345.30, 0.35),
    Funding("QQQ", "Invesco Trust Shares Inc.", RET_CODE.PLACED, 0, 15000, 345.30, 0.75),
    Funding("A1", "A1 Capital Inc.", RET_CODE.PLACED, 0, 15000, 345.30, 0.56),
    Funding("TMNT", "Teenage Mutant Ninja Turtles.", RET_CODE.PLACED, 0, 15000, 345.30, 0.543),
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
          builder: (context) {
          return CustomScrollView(
            slivers: [
              /*SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),*/
              SliverAppBar(
                title: Text("Fonlamalar"),
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
                              //onTap: () => gotoDetailsView(context),
                              child: FundingsCard(
                                funding: fundingsList[index],),
                            ),
                            Divider(height: 1,
                              indent: 50.0,
                              endIndent: 50.0,
                              color: lightColorScheme.primaryContainer,
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: fundingsList.length
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

/*
void gotoDetailsView(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsView()));
}*/
