
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';


class DetailsView extends StatefulWidget {
  DetailsView({Key? key}) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsState();

}

class _DetailsState extends State<DetailsView> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (context) => CustomScrollView(
          slivers: [
            //SliverOverlapInjector(
            //handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            SliverAppBar(
              expandedHeight: height * 0.3,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Colors.red,
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
                          //onTap: () => gotoDetailsView(context),
                          child: Container(
                            height: height * 0.3,
                            color: Colors.red,
                          ),
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
                    childCount: 1
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}