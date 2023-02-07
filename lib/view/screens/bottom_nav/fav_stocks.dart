import 'package:flutter/material.dart';
import 'package:pay_match/constants/network_constants.dart';
import 'package:pay_match/model/data_models/portfolio/Asset.dart';
import 'package:pay_match/model/observables/stocks_model.dart';
import 'package:pay_match/utils/colors.dart';
import 'package:pay_match/utils/styles/text_styles.dart';
import 'package:pay_match/view/screens/secondaries/stocks.dart';
import 'package:pay_match/view/ui_tools/loading_screen.dart';
import 'package:provider/provider.dart';
import '../../ui_tools/nav_drawer.dart';

class FavsView extends StatelessWidget {
  const FavsView({Key? key}) : super(key: key);

  void _goToStocks(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const StocksView()));
  }

  @override
  Widget build(BuildContext context) {
    StocksModel model=context.watch<StocksModel>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Icon(Icons.flutter_dash_sharp),
        actions: <Widget>[
        ],
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          _goToStocks(context);
        },
      ),
      body: context.watch<StocksModel>().favState == NetworkState.LOADING ? const LoadingScreen() :
      context.watch<StocksModel>().favState == NetworkState.ERROR ? const ErrorScreen() :
          ListView.separated(
            itemCount: model.favAssets.length,
              itemBuilder: (BuildContext context, int index){
            return GestureDetector(
              onTap: () {
                //
              },
              onLongPress: () {
              },
              child: buildFavCard(model.favAssets[index]),
            );
          },
            separatorBuilder: (BuildContext context, int index) {
              return  Divider(
              indent: 50.0,
              endIndent: 50.0,
              color: lightColorScheme.primaryContainer,
              height: 1.0,
              thickness: 0,
            );
          },
        ),
    );
  }
}

Widget buildFavCard(Asset asset) => Card(
  margin: EdgeInsets.all(0.0),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
  color: lightColorScheme.onSecondary,
  child: Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ClipOval(
            child: Image.network("https://play-lh.googleusercontent.com/8MCdyr0eVIcg8YVZsrVS_62JvDihfCB9qERUmr-G_GleJI-Fib6pLoFCuYsGNBtAk3c",
              width: 60.0,
              height: 60.0,
              fit: BoxFit.fill,
            ),
          ),
          flex: 1,
        ),
        SizedBox(width: 16.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(asset.fullName,
                  style: kSymbolNameTextStyle),
              SizedBox(height: 8.0,),
              Text(asset.symbol,
                style: kSymbolTextStyle,),

            ],
          ),
          flex: 3,
        ),
        Expanded(
          flex: 1,
          child:
          (asset.percChange > 0)
          ?
            Text(
              "+${(asset.percChange.toString())}%",
              style: TextStyle(
                color: Colors.green,
                letterSpacing: 1.3,
            ),
          )
          :
          Text(
          "-${(asset.percChange.toString())}%",
            style: TextStyle(
              color: Colors.red,
              letterSpacing: 1.3,
            ),
          )
        ),

        Expanded(flex:1,
          child: Text("₺ ${(asset.bid.toString())}",
            style: kPriceTextStyle,
          ),
        ),
      ],
    ),
  ),
);

