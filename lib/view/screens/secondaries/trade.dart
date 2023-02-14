import 'package:flutter_spinbox/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:pay_match/utils/colors.dart';
import 'package:pay_match/utils/styles/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../constants/network_constants.dart';
import '../../../model/observables/stocks_model.dart';

class TradeView extends StatefulWidget {
  const TradeView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _TradeViewState();
}


class _TradeViewState extends State<TradeView> {


  //Toggle switch initial index
  int? initialIndex = 0;
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

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    StocksModel model = context.watch<StocksModel>();
    NetworkState networkState = model.allState;
    //resizeToAvoidBottomInset -> important when keyboard will be opened
    return Scaffold(
      resizeToAvoidBottomInset : false,
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
                    child: Text("Sembol Kodu:"), ),
                  Expanded(
                    flex: 2,
                    child: DropDownTextField(
                      //initialValue: dropdownItems[0],
                      enableSearch: true,
                      textFieldDecoration: InputDecoration(
                        //errorText: "Sembol Bulunamamıştır",
                        hintText: "Hisse seçin veya arayın",

                        ),


                      keyboardType: TextInputType.name,
                      dropDownList: dropdownItems,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30,),
              Row(
                children: <Widget>[
                  const Expanded( flex: 1,
                      child: Text("Emir Fiyat Tipi:")),
                  SizedBox(width: 8.0,),
                  Expanded( flex: 2,
                    child: DropDownTextField(
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
              SizedBox(height: 30,),
              Row(
                children: <Widget>[
                  const Expanded(
                      flex: 1,
                      child: Text("Fiyat:")),
                  const SizedBox(width: 8.0,),
                  Expanded(
                    flex: 2,
                    child: DropDownTextField(
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
              SizedBox(height: 30,),
              //TODO::implement MaxFindingFunction
              Row(
                children: <Widget> [
                  Expanded(
                      flex: 1,
                      child: Text("Adet:")),
                  SizedBox(width: 8.0 ,),
                  Expanded(
                    flex: 3,
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
              SizedBox(height: 30,),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                      child: Text("Toplam Tutar:")),
                  SizedBox(
                    width: 8.0,),
                  Expanded(
                    flex: 3,
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

              SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ToggleSwitch(
                    initialLabelIndex: initialIndex,
                      //cornerRadius: 20.0,
                    minHeight: 60.0,
                    customWidths: [(width / 2 - 30), (width / 2 - 30)],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    labels: [
                      "AL", "SAT"
                    ],
                    customTextStyles: [kOnButtonLightTextStyle,kOnButtonLightTextStyle],
                    activeBgColors: [[AppColors.green2, AppColors.green1], [Colors.yellow, Colors.orange]],
                    animate: true, // with just animate set to true, default curve = Curves.easeIn
                    curve: Curves.bounceInOut, // animate must be set to true when using custom curve
                    onToggle: (index) {
                      print('switched to: $index');
                      setState(() {
                        initialIndex = index;
                        }
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}