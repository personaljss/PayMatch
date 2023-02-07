import 'package:flutter/material.dart';
import 'package:pay_match/constants/network_constants.dart';
import 'package:pay_match/model/observables/stocks_model.dart';
import 'package:pay_match/utils/colors.dart';
import 'package:pay_match/utils/styles/text_styles.dart';
import 'package:pay_match/view/ui_tools/stock_card.dart';
import 'package:provider/provider.dart';

import '../../../model/data_models/portfolio/Asset.dart';
import '../../ui_tools/loading_screen.dart';

class StocksView extends StatefulWidget {
  const StocksView({Key? key}) : super(key: key);

  @override
  State<StocksView> createState() => _StocksViewState();
}

class _StocksViewState extends State<StocksView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _searchStocks(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    StocksModel model = context.watch<StocksModel>();
    NetworkState networkState = model.allState;
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text("stocks"),
        actions: <Widget>[
          IconButton(
              onPressed: () => {_searchStocks(context)},
              icon: const Icon(Icons.search))
        ],
      ),
      body: (networkState == NetworkState.LOADING)
          ? const LoadingScreen()
          : (networkState == NetworkState.ERROR)
              ? const ErrorScreen()
              : Container(
                color: lightColorScheme.onSecondary,
                child: ListView.separated(

                    itemCount: model.allAssets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(

                        onTap: () {
                          //will be implemented
                        },
                        child: //AssetItem(asset: model.allAssets[index],),
                        buildCard(model.allAssets[index]),
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
              ),
    );
  }

  Widget buildCard(Asset asset) => Card(
        margin: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        color: lightColorScheme.onSecondary,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Expanded(flex: 1,
                child: Text(asset.sector), ),
              /*Expanded(
                flex: 1,
                child: Text(
                  asset.percChange.toString(),
                  style: TextStyle(
                      color:
                          (asset.percChange > 0) ? Colors.green : Colors.red),
                ),
              ),*/
              /*Expanded(flex:1,
                  child: Text(asset.bid.toString())),*/
              Expanded(flex: 1,
                  child: _FavButton(
                asset: asset,
              ))
            ],
          ),
        ),
      );
}

class _FavButton extends StatefulWidget {
  const _FavButton({required Asset asset}) : _asset = asset;
  final Asset _asset;

  @override
  State<_FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<_FavButton> {
  NetworkState _networkState = NetworkState.DONE;

  @override
  Widget build(BuildContext context) {
    StocksModel model = context.watch<StocksModel>();
    bool isFav = context.select<StocksModel, bool>(
        (model) => model.favAssets.contains(widget._asset));
    if (_networkState == NetworkState.LOADING) {
      return Transform.scale(
        scale: 0.5,
        child: const CircularProgressIndicator(),
      );
    }
    return IconButton(
        onPressed: () async {
          if (_networkState == NetworkState.DONE) {
            setState(() {
              _networkState = NetworkState.LOADING;
            });
          }
          bool res = false;
          if (isFav) {
            res = await model.unFollowAsset(widget._asset);
          } else {
            res = await model.followAsset(widget._asset);
          }
          setState(() {
            _networkState = NetworkState.DONE;
          });
        },
        icon: (isFav) ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline_sharp));
  }
}
