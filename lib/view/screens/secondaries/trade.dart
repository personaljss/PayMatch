import 'package:flutter_spinbox/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:pay_match/utils/styles/text_styles.dart';
import 'package:provider/provider.dart';

import '../../../constants/network_constants.dart';
import '../../../model/observables/stocks_model.dart';

class TradeView extends StatefulWidget {
  const TradeView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _TradeViewState();
}


class _TradeViewState extends State<TradeView> {

//fake implementation
  List<DropDownValueModel> get dropdownItems {
    List<DropDownValueModel> menuItems = [
      DropDownValueModel(value: "AAPL", name: 'AAPL'),
      DropDownValueModel(value: "NVDA", name:"NVDA"),
      DropDownValueModel(value: "AMD",  name:"AMD"),
      DropDownValueModel(value: "FB",  name:"FB"),
    ];
    return menuItems;
  }
  List<DropDownValueModel> get dropdownMenuItems {
    List<DropDownValueModel> menuItems = [
      DropDownValueModel(value: "Limit", name: 'LMT'),
      DropDownValueModel(value: "Market", name:"MKT"),
    ];
    return menuItems;
  }

  //TODO: implement controller and onChanged to the fields
  //TODO: implement adet slider, buy/sell boxes,
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    StocksModel model = context.watch<StocksModel>();
    NetworkState networkState = model.allState;
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text("Emir Girişi",
          style: kHeadingTextStyle,
        ),
      ),
      body: Padding(padding: EdgeInsets.all(20),
        child: Form(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Expanded(
                    flex: 1,
                    child: Text("Sembol Kodu"), ),
                  Expanded(
                    flex: 2,
                    child: DropDownTextField(
                      enableSearch: true,
                      searchDecoration: InputDecoration(
                        //hintText:
                        label: Text("Coco"),
                        labelStyle: kLabelLightTextStyle,
                      ),
                      keyboardType: TextInputType.name,
                      dropDownList: dropdownItems,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Expanded(child: Text("Emir Fiyat Tipi:")),
                  SizedBox(width: 8.0,),
                  Expanded(child: DropDownTextField(
                    enableSearch: true,
                    searchDecoration:
                    InputDecoration(
                      label: Text("Coco"),
                      labelStyle: kLabelLightTextStyle,
                    ),
                    keyboardType: TextInputType.name,
                    dropDownList: dropdownMenuItems,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Expanded(child: Text("Fiyat")),
                  const SizedBox(width: 8.0,),
                  Expanded(child: DropDownTextField(
                    enableSearch: true,
                    searchDecoration:
                      InputDecoration(
                      label: Text("356.67"),
                      labelStyle: kLabelLightTextStyle,
                      ),
                    keyboardType: TextInputType.number,
                    dropDownList: dropdownItems,
                    ),
                  ),
                ],
              ),
              //TODO::implement MaxFindingFunction
              Row(
                children: <Widget> [
                  Expanded(child: Text("Adet")),
                  SizedBox(width: 8.0 ,),
                  Expanded(child: SpinBox(
                    min: 0.0,
                    max: 5000.0,
                    value: 365.65 ,
                    onChanged: (double) => () {},
                    decimals: 2,
                    step: 0.01,
                    keyboardType: TextInputType.number,
                    acceleration: 0.03,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Text("Toplam Tutar")),
                  SizedBox(
                    width: 8.0,),
                  Expanded(
                      child: SpinBox(
                      min: 0.0,
                      max: 5000.0,
                      value: 365.65 ,
                      onChanged: (double) => () {},
                      decimals: 2,
                      step: 0.01,
                      keyboardType: TextInputType.number,
                      acceleration: 0.03,
                    ),
                  ),
                ],
              ),
              /*
              Row(
                children: <Widget>[
                  Slider(value: 20, onChanged: (value) {

                  }
                  ),
                ],
              ),*/


            ],
          ),
        ),
      ),
    );
  }


}