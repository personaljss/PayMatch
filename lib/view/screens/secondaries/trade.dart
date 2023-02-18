import 'package:flutter_spinbox/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:pay_match/model/data_models/trade/Orders.dart';
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
  //formKey for sending requests to server to handle events in fields
  final controllerOrderType = SingleValueDropDownController();
  final controllerSymbolCode = SingleValueDropDownController();
  final _formkey = GlobalKey<FormState>();
  //members for interwidget communication
  TradeRequest? request;
  String symbol = "AAPL";
  //why not enum??
  String? orderType;
  double price = 0;
  double volume = 0;
  double total = 0;

//fake implementation
  List<DropDownValueModel> get dropdownItems {
    List<DropDownValueModel> menuItems = [
      const DropDownValueModel(value: "AAPL", name: 'AAPL'),
      const DropDownValueModel(value: "NVDA", name:"NVDA"),
      const DropDownValueModel(value: "AMD",  name:"AMD"),
      const DropDownValueModel(value: "FB",  name:"FB"),
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
  //Fake impl for data request
  void initRequest() {
    symbol = "AAPL";
    orderType = "LMT";
    price =  36.52;
    volume = 100;
    total = price * volume;
  }

  //methods to get DropDown value of the DropdownTextField
  void _saveOrderType() {
    if (controllerOrderType.dropDownValue != null  && !controllerOrderType.dropDownValue.toString().isEmpty) {
      orderType = controllerOrderType.dropDownValue.toString();
      print(orderType);
    }
  }

  void _saveSymbolCode() {
    if (controllerSymbolCode.dropDownValue != null  && !controllerSymbolCode.dropDownValue.toString().isEmpty) {
      symbol = controllerSymbolCode.dropDownValue.toString();
      print(symbol);
    }
  }

  @override
  void initState() {
    super.initState();
    controllerOrderType.addListener(_saveOrderType);
    controllerSymbolCode.addListener(_saveSymbolCode);
    initRequest();
    //add listeners to controller
  }

  @override
  void dispose() {
    controllerOrderType.dispose();
    controllerSymbolCode.dispose();
    super.dispose();
  }
  //DONE: onChanged and validator are put into Spinbox, implemented buy/sell boxes
  //TODO: implement onChanged to symbol and orderTypefields
  //TODO: implement adet slider,

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
          key: _formkey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: Text("Sembol Kodu:"), ),
                    Expanded(
                      flex: 2,
                      child: DropDownTextField(
                        controller: controllerSymbolCode,
                        //initialValue: dropdownItems[0],
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            return "Sembol Seçin";
                          }
                          return null;
                        },
                        //Bug:: DropDown doesn't collapse
                        /*onChanged: (value) {
                          if (value != null && !value.isEmpty){
                            orderType = value;
                            setState(() {
                            });
                          }
                        },*/

                        enableSearch: true,
                        textFieldDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          //errorText: "Sembol Bulunamamıştır",
                          hintText: "Hisse seçin veya arayın",

                          ),
                        keyboardType: TextInputType.name,
                        dropDownList: dropdownItems,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24,),
              Expanded(
                child: Row(
                  children: <Widget>[
                    const Expanded( flex: 1,
                        child: Text("Emir Fiyat Tipi:")),
                    SizedBox(width: 8.0,),
                    Expanded( flex: 2,
                      child: DropDownTextField(
                        controller: controllerOrderType,
                        //initialValue: orderType,
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            return "Sembol Seçin";
                          }
                          return null;
                        },
                        //Bug:: DropDown doesn't collapse
                        /*onChanged: (value) {
                          if (value != null && !value.isEmpty){
                            orderType = value;
                          }
                        },*/
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
              ),
              SizedBox(height: 24,),
              Expanded(
                child: Row(
                  children: <Widget>[
                    const Expanded(
                        flex: 1,
                        child: Text("Fiyat:")),
                    const SizedBox(width: 8.0,),
                    Expanded(
                      flex: 3,
                      child: SpinBox(

                        min: 0.0,
                        max: 5000.0,
                        value: price ,
                        onChanged: (value) {
                          price = value;
                          setState(() {
                            total = price * volume!;
                          });
                        },
                        decimals: 2,
                        step: 0.01,
                        keyboardType: TextInputType.number,
                        acceleration: 0.03,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24,),
              //TODO::implement MaxFindingFunction
              Expanded(
                child: Row(
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
                        value: volume ,
                        onChanged: (value)  {
                          volume = value;
                          setState(() {
                            total = price * volume;
                          });
                        },

                        decimals: 2,
                        step: 0.01,
                        keyboardType: TextInputType.number,
                        acceleration: 0.03,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24,),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                        child: Text("Toplam Tutar:")),
                    SizedBox(width: 8.0,),
                    Expanded(
                      flex: 3,
                      child: SpinBox(
                        min: 0.0,
                        max: 500000.0,
                        value: total,
                        onChanged: (value){
                          total = value;
                          setState(() {
                            if(price != 0){
                              volume = total / price;
                            }
                            else{
                              volume = total;
                              price = 1.0;
                            }
                          });
                        },
                        decimals: 2,
                        step: 0.01,
                        keyboardType: TextInputType.number,
                        acceleration: 0.03,
                      ),
                    ),
                  ],
                ),
              ),
              /*
              Row(
                children: <Widget>[
                  Slider(value: 20, onChanged: (value) {

                  }
                  ),
                ],
              ),*/

              SizedBox(height: 24,),

              Expanded(
                child: Row(
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
              ),
              SizedBox(height: 24,),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom( backgroundColor: Colors.blue),
                        onPressed: () {
                        if(_formkey.currentState!.validate()){
                          //_formkey.currentState!.save();
                          print(symbol);
                          print(orderType);
                          print(price);
                          print(volume);
                          print(total);
                          //TODO:: Implement httpRequest
                          }
                        },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("ONAYLA",
                          style: kLabelLightTextStyle,
                          ),
                      ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}