
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/styles/text_styles.dart';
import '../../ui_tools/details_card.dart';
import '../../ui_tools/details_header_card.dart';


class DetailsView extends StatefulWidget {
  DetailsView({Key? key}) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsState();

}

class _DetailsState extends State<DetailsView> {
  List<String> headers = ["Fiyat", "Değişim", "Değişim %", "Hacim", "Piyasa Değeri",
    "52 Hafta Yüksek", "52 Hafta Düşük", "Halka Arz Pay Sayısı", "P/E Oranı", "Halka Arz Fiyatı", ];
  List<double> values = [35.47, 11.05, 37.34, 100000, 3500000, 35.47, 17.25, 1000000, 3.75, 17.25];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: Text('Details', style: kChangeGreenTextStyle,),
                  /*leading: Builder(
                      builder: (context) {
                        return IconButton(

                          icon: Icon(Icons.arrow_back),
                          color: lightColorScheme.primaryContainer,
                          onPressed: () => Navigator.pop(context),
                        );
                      }
                    ),*/
                  //automaticallyImplyLeading: true,

                  expandedHeight: height * 0.4,
                  floating: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    //title: Text('Details', style: kChangeGreenTextStyle,),
                    collapseMode: CollapseMode.parallax,
                    background: DetailsHeaderCard(),
                  ),
                ),
              ),
            ];
          },
          body: Builder(
            builder: (context) => CustomScrollView(
              slivers: [
                SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
                //SliverAppBar(),
                /*SliverToBoxAdapter(
                  child: DetailsHeaderCard(),
                ),*/
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
                              child: Container(
                                child: DetailsCard(header: headers[index], value: values[index],),
                                height: height * 0.1,
                                color: Colors.white,
                              ),
                            ),
                            /*Divider(height: 1,
                                indent: 50.0,
                                endIndent: 50.0,
                                color: lightColorScheme.primaryContainer,
                              ),*/
                          ],
                        ),
                      );
                    },
                        childCount: headers.length
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}