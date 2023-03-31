import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_match/model/data_models/base/Asset.dart';
import 'package:pay_match/model/observables/user_model.dart';
import 'package:pay_match/view/ui_tools/stock_card.dart';
import 'package:provider/provider.dart';

class StockSearchDelegate extends SearchDelegate {
  StockSearchDelegate({required this.listName});
  final String listName;
// Demo list to show querying
  List<Asset> searchTerms = [];

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    searchTerms=context.select<UserModel,List<Asset>>((model)=>model.allAssets);
    List<Asset> matchQuery = [];
    for (Asset asset in searchTerms) {
      if (asset.symbol.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(asset);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return StockCard(asset: result, listName: listName,);
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    searchTerms=context.select<UserModel,List<Asset>>((model)=>model.allAssets);
    List<Asset> matchQuery = [];
    for (Asset asset in searchTerms) {
      if (asset.symbol.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(asset);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return StockCard(asset: result, listName: listName,);
      },
    );
  }
}
