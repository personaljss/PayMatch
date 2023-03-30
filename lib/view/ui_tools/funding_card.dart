import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_match/view/screens/secondaries/details.dart';
import '../../model/data_models/base/fundings_model.dart';
import '../../utils/colors.dart';
import '../../utils/styles/text_styles.dart';

class FundingsCard extends StatelessWidget {
  Funding funding;

  FundingsCard({Key? key,required this.funding});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return buildFundingsCard(context, funding, height, width);
  }

  Widget buildFundingsCard(BuildContext context, Funding funding, double height, double width) => Container(
    height: height * 0.55,
    child:   Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      color: lightColorScheme.onPrimary,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child:
              Row(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        padding: EdgeInsets.fromLTRB(6.0, 30.0, 0, 0),
                        width: width,
                        height: height * 0.35,
                        decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(6.0),
                          image: DecorationImage(
                            image: AssetImage("assets/logo.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child:
                        Text("A1 Capital",
                          style: kLabelLightTextStyle,)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0,),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                      child: Text("A1 Capital; Hisse Senedi ve VİOP işlemlerine aracılık, Yatırım Danışmanlığı, Portföy Yönetimi, Halka Arz, Borçlanma Aracı İhraçları, Şirket Değerlemesi, Şirket Satın Alma ve Birleşme, Proje Finansmanı..."))
                ],
              ),
            ),
            SizedBox(height: 16.0,),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipOval(
                      child: Image.network("https://play-lh.googleusercontent.com/8MCdyr0eVIcg8YVZsrVS_62JvDihfCB9qERUmr-G_GleJI-Fib6pLoFCuYsGNBtAk3c",
                        width: 60.0,
                        height: 60.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0,),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(funding.symbol,
                            style: kSymbolNameTextStyle),
                        const SizedBox(height: 8.0,),
                        Text((funding.fullName).length < 20 ? funding.fullName : "${funding.fullName.substring(0,20)}...",
                          style: kSymbolTextStyle,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0,),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  //USED Stack instead of linear progress indicator
                  //TODO:: solve text bug(percentage is not fully visible when less than 20%)
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: width,
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                            color: lightColorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          //color: lightColorScheme.primaryContainer,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          padding: EdgeInsets.all(2.0),
                          height: double.maxFinite,
                          width: width * funding.fundedPercentage,
                          decoration: BoxDecoration(
                            color: lightColorScheme.inversePrimary,
                            borderRadius: BorderRadius.circular(8.0),
                          ),

                        ),
                        Center(
                          child: Text( "${((funding.fundedPercentage) * 100).toStringAsFixed(2)}%",
                            style: kLabelUnoTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0,),
            Expanded(
              flex: 1,
              child: Text(" Kalan Hedef ${(funding.volumeRemaining * funding.price)}₺",
              ),
            ),
            SizedBox(height: 16.0,),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            width: 1.0,
                            color: Colors.green),),
                      onPressed: () {

                      },
                      child: Text("Yatırım Yap",
                        style: kButtonGreenTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0,),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            width: 1.0,
                            color: lightColorScheme.onPrimaryContainer),),
                      onPressed: () {
                        _gotoDetailsView(context);
                      },

                      child: Text("İncele",
                        style: kButtonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

}


void _gotoDetailsView(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DetailsView(symbol: "",)));
}

