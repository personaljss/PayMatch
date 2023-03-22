
import 'package:flutter/material.dart';
import '../../utils/styles/text_styles.dart';

class DetailsHeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    return Card(
      margin: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, height * 0.1, 0, 0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: ClipOval(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset('assets/logo.png',
                  scale: 1.0,
                  isAntiAlias: true,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Text("A1 Capital",
                textAlign: TextAlign.center,
                style: kHeadingTextStyle,
              ),
            ),
            Expanded(
              child: Text("A1 Capital Yatırım Menkul Değerler A.Ş.",
                textAlign: TextAlign.center,
                style: kSymbolTextStyle,
              ),
            ),
            Expanded(
              child: Text("Finansal Yatırım Hizmetleri",
                textAlign: TextAlign.center,
                style: kSymbolTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
