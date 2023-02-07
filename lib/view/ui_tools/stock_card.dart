
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
  const AssetItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StocksModel stocksModel=context.watch<StocksModel>();
    return const Card(

    );
  }
}
