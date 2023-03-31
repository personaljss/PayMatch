import 'package:flutter/material.dart';
import 'package:pay_match/model/observables/user_model.dart';
import 'package:provider/provider.dart';

import '../../model/services/sp_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController=TextEditingController();
  final TextEditingController _pwdController=TextEditingController();
  late final String _pwdHint;
  late final String _phoneHint;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pwdHint=((Prefs.instance().getLoginPassword()==null)?"":Prefs.instance().getLoginPassword())!;
    _phoneHint=((Prefs.instance().getPhoneNumber()==null)?"":Prefs.instance().getPhoneNumber())!;
    _pwdController.text=_pwdHint;
    _phoneController.text=_phoneHint;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("giriş"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50,),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'telefon numarası',
                    hintText: 'telefon numaranızı girin'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: _pwdController,
                obscureText: true,
                //enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Şifre',
                    hintText: 'şifrenizi girin'),
              ),
            ),
            TextButton(
              onPressed: (){
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: const Text(
                'Şifrenizi mi unuttunuz',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Provider.of<UserModel>(context,listen: false).logIn(_phoneController.text, _pwdController.text);
                },
                child: const Text(
                  'Giriş yap',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            TextButton(onPressed: (){},
                child: const Text('kayıtlı değil misiniz?,hesap oluşturun'))
          ],
        ),
      ),
    );
  }
}