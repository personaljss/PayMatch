import 'package:flutter/material.dart';
import 'package:pay_match/constants/network_constants.dart';
import 'package:pay_match/model/observables/stocks_model.dart';
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
      body: context.watch<StocksModel>().favState==NetworkState.LOADING? const LoadingScreen() :
      context.watch<StocksModel>().favState==NetworkState.ERROR? const ErrorScreen() :
          ListView.builder(
            itemCount: model.favAssets.length,
              itemBuilder: (BuildContext context, int index){
            return GestureDetector(
              onTap: () {
                //
              },
              onLongPress: () {
              },
              child: Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(child:
                          Text(model.favAssets[index].symbol)
                        ),
                        Expanded(child:
                          Text(model.favAssets[index].sector)
                        ),
                        Expanded(
                          child: Text(
                            model.favAssets[index].percChange.toString(),
                            style: TextStyle(
                                color: (model.favAssets[index].percChange > 0)
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ),
                        Expanded(child:
                          Text(model.favAssets[index].ask.toString())
                        ),
                        Expanded(child:
                          Text(model.favAssets[index].bid.toString())
                        ),
                      ],
                    ),
                  )
              ),
            );
          })
    );
  }
}
