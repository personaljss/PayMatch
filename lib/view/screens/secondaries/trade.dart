import 'package:flutter_spinbox/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:pay_match/main.dart';
import 'package:pay_match/model/data_models/base/Transaction.dart';
import 'package:pay_match/model/data_models/trade/Orders.dart';
import 'package:pay_match/model/observables/user_model.dart';
import 'package:pay_match/utils/colors.dart';
import 'package:pay_match/utils/styles/text_styles.dart';
import 'package:pay_match/view/ui_tools/tiriviri.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';


class TradeView extends StatefulWidget {
  /*since generally user will open this page from a stock, the symbol field can be initialised
  while creating this class' object however, if it is opened from nowhere the defaultSymbol variable
  will be passed as a constructor argument
  * */
  static const String defaultSymbol="defaultSymbol";
  const TradeView({Key? key,required this.symbol}) : super(key: key);
  final String symbol;
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
  late String symbol;
  //why not enum??
  late String orderType;
  double price = 0;
  double volume = 0;
  double total = 0;

//fake implementation
  late List<DropDownValueModel> symbolsDropDown;
  List<DropDownValueModel> ordersDropDown=[
    const DropDownValueModel(name: "Limit emir", value: 0),
    const DropDownValueModel(name: "Market emri", value: 1),
  ];

  //methods to get DropDown value of the DropdownTextField
  void _saveOrderType() {
    if (controllerOrderType.dropDownValue != null  && controllerOrderType.dropDownValue.toString().isNotEmpty) {
      orderType = controllerOrderType.dropDownValue.toString();
      print(orderType);
    }
  }

  void _saveSymbolCode() {
    if (controllerSymbolCode.dropDownValue != null  && controllerSymbolCode.dropDownValue.toString().isNotEmpty) {
      symbol = controllerSymbolCode.dropDownValue.toString();
      print(symbol);
    }
  }

  @override
  void initState() {
    super.initState();
    symbol=widget.symbol;
    List<String> symbols=Provider.of<UserModel>(context,listen: false).symbolsMap.keys.toList();
    symbolsDropDown=symbols.map((e) => DropDownValueModel(name: e, value: e)).toList();

    controllerOrderType.addListener(_saveOrderType);
    controllerSymbolCode.addListener(_saveSymbolCode);
    //showing source symbol on the menu
    controllerSymbolCode.dropDownValue=DropDownValueModel(name: symbol, value: symbol);
    //showing limit order as default
    controllerOrderType.dropDownValue=const DropDownValueModel(name: "Limit emir", value: 0);
    orderType="Limit emir";
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
    //double height = MediaQuery.of(context).size.height;

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
                        onChanged: (value){
                          symbol=value.value;
                          //symbol=value;
                        },
                        enableSearch: true,
                        textFieldDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          ),
                        keyboardType: TextInputType.name,
                        dropDownList: symbolsDropDown,
                      ),
                    ),
                  ],
                ),
                ),

                const SizedBox(height: 30),

                Row(
                  children: <Widget>[
                    const Expanded( flex: 1,
                        child: Text("Emir Fiyat Tipi:")),
                    const SizedBox(width: 8.0,),
                    Expanded( flex: 2,
                      child: DropDownTextField(
                        controller: controllerOrderType,
                        enableSearch: true,
                        keyboardType: TextInputType.name,
                        dropDownList: ordersDropDown,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                Row(
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
                const SizedBox(height: 30,),
                //TODO::implement MaxFindingFunction
                Row(
                  children: <Widget> [
                    const Expanded(
                        flex: 1,
                        child: Text("Adet:")),
                    const SizedBox(width: 8.0 ,),
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

                SizedBox(height: 30,),
                Row(
                  children: <Widget>[
                    const Expanded(
                      flex: 1,
                        child: Text("Toplam Tutar:")),
                    const SizedBox(width: 8.0,),
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

                const SizedBox(height: 30,),

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
                      labels: const [
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
                const SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom( backgroundColor: Colors.blue),
                        onPressed: () async{
                        if(_formkey.currentState!.validate()){
                          //Validating the order properties
                          if(symbol.isEmpty || price<=0 || volume<=0 || orderType.isEmpty){
                            displaySnackBar(context, "lütfen geçerli bir emir giriniz");
                            return;
                          }
                          OrderType type=(initialIndex==0)?OrderType.BUY_LIMIT:OrderType.SELL_LIMIT;
                          TradeRequest request=TradeRequest(symbol, price, volume, type, 0, 0, 0, 0, 0);
                          TradeResponse response=await Provider.of<UserModel>(context,listen: false).orderSend(request);
                          if(context.mounted){
                            if(response==TradeResponse.success){
                              displaySnackBar(context, "işlem başarılı");
                              //navigating to the portfolio
                              Navigator.pushNamed(context, ParentPage.routeName,arguments: {ParentPage.routeName: 1});
                            }else if(response==TradeResponse.noMoney){
                              displaySnackBar(context, "Bakiyeniz yetersiz.");
                            }else if(response==TradeResponse.failure){
                              displaySnackBar(context, "işlem başarısız");
                            }else{
                              displaySnackBar(context, "emriniz iletilemedi");
                            }
                          }
                          }
                        },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("ONAYLA",
                          style: kLabelLightTextStyle,
                          ),
                      ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}