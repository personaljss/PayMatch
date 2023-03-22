
import 'package:flutter/material.dart';

import '../../utils/styles/text_styles.dart';


class DetailsCard extends StatelessWidget {
  double value;
  String header;

  DetailsCard({Key? key,required this.value,required this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 1,
            child: Text(header,
              style: kSymbolNameTextStyle,
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(flex: 1,
            child: Text("${value}",
              style: kPriceTextStyle,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}