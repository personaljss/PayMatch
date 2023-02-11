import 'package:flutter/material.dart';
import '../../model/data_models/base/Asset.dart';

class StocksCard extends StatelessWidget {
  const StocksCard({Key? key, required this.asset}) : super(key: key);
  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(asset.symbol),
    );
  }
}
