
import 'package:flutter/material.dart';
import 'package:pay_match/model/observables/stocks_model.dart';
import 'package:provider/provider.dart';

import '../../model/data_models/portfolio/Asset.dart';

class _AddButton extends StatelessWidget {
  final Asset asset;

  const _AddButton({required this.asset});

  @override
  Widget build(BuildContext context) {
    var isInFavs = context.select<StocksModel, bool>(
      // Here, we are only interested whether [item] is inside the cart.
      (stocks) => stocks.favAssets.contains(asset),
    );
    return TextButton(
      onPressed: isInFavs
          ? () {
              StocksModel stocksModel = context.read<StocksModel>();
              stocksModel.followAsset(asset);
            }
          : () {
              StocksModel stocksModel = context.read<StocksModel>();
              stocksModel.followAsset(asset);
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isInFavs
          ? const Icon(Icons.done, semanticLabel: 'ADDED')
          : const Icon(Icons.remove_circle_outline, semanticLabel: 'NOT ADDED'),
    );
  }
}

class AssetItem extends StatelessWidget {
  final Asset asset;
  const AssetItem({Key? key, required this.asset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StocksModel stocksModel=context.watch<StocksModel>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Row(
          children: <Widget>[
            Expanded(child: Text(asset.symbol)),
            Expanded(child: Text(asset.sector)),
            Expanded(
              child: Text(
                asset.percChange.toString(),
                style: TextStyle(
                    color:
                    (asset.percChange > 0) ? Colors.green : Colors.red),
              ),
            ),
            Expanded(child: Text(asset.ask.toString())),
            Expanded(child: Text(asset.bid.toString())),
            /*Expanded(
                child: _AddButton(
                  asset: asset,
                )),*/
          ],
        ),
      ),

    );
  }
}
