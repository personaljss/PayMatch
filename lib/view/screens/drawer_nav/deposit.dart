import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/observables/user_model.dart';

class DepositView extends StatefulWidget {
  DepositView({Key? key}) : super(key: key);

  @override
  State<DepositView> createState() => _DepositViewState();
}

class _DepositViewState extends State<DepositView> {
  final TextEditingController _controller=TextEditingController();
  void _showSnackBar(BuildContext context,String txt){
    final snackBar = SnackBar(
      content: Text(txt),
      );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void _onPressed(BuildContext context) async{
    double amount=double.parse(_controller.text);
    if(amount>0){
      bool res=await Provider.of<UserModel>(context,listen: false).portfolio.deposit(amount, "TL");
      (res)?_showSnackBar(context, "işlem başarılı"):_showSnackBar(context, "işlem başarısız");
    }else{
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 90),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'para miktarı',
                hintText: 'yüklemek istediğiniz miktarı girin'),
          ),
        ),
          const SizedBox(height: 50),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              onPressed: () =>_onPressed(context),
              child: const Text(
                'yükle',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
