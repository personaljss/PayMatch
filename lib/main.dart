import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pay_match/model/observables/stock_ticker.dart';
import 'package:pay_match/model/observables/user_model.dart';
import 'package:pay_match/view/screens/bottom_nav/fundings/fundings.dart';

import 'package:pay_match/view/screens/bottom_nav/home/home.dart';
import 'package:pay_match/view/screens/bottom_nav/portfolio/portfolio.dart';
import 'package:pay_match/view/screens/login.dart';
import 'package:pay_match/view/ui_tools/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/network_constants.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;

void main() async {
/*
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getToken();

 */

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserModel>(
      create: (context) => UserModel(),
    )
  ], child: const MyApp())
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'PayMatch';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      initialRoute: '/',
      routes: {
        ParentPage.routeName : (context) => const ParentPage()
      },
      home: const ParentPage(),
    );
  }
}

class ParentPage extends StatefulWidget {
  const ParentPage({super.key});
  static const routeName="/home_page";
  static const indexNavKey="index_selected";

  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> with WidgetsBindingObserver {
  final List<Widget> screens = [
    const HomeView(),
    FundingsView(),
    const PortfolioView()
  ];
  bool _isBackground = false;
  int _selectedIndex = 0;
  late int userCode;
  bool isUserCodeSet = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  _serverInfo(bool online) async {
    Uri url = Uri.parse(ApiAdress.server + ApiAdress.onDispose);
    SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      Response response = await http.post(url, body: {
        "online": online ? "1" : "0",
        "key": "1",
        "value": "1",
        "usercode": userCode.toString(),
        "size": "6",
        "devicetoken": sp.getString("deviceToken")
      });
      if (online) {
        _isBackground = true;
      } else {
        _isBackground = false;
      }
      print(response.body);
    } catch (e) {
//
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!isUserCodeSet) {
      return;
    }
    if (state == AppLifecycleState.paused) {
      print("paused");
      _serverInfo(false);
    }
    if (state == AppLifecycleState.resumed) {
      print("resumed");
      _serverInfo(true);
      model.fetchPortfolio();
    }
  }

  late UserModel model;

  @override
  Widget build(BuildContext context) {
    LoginStatus loginStatus =
        context.select<UserModel, LoginStatus>((model) => model.status);
    if (loginStatus == LoginStatus.success) {
      //checking if there is any arguments when navigating this screen
      final args = ModalRoute.of(context)!.settings.arguments as Map<String,int>;
      if(args[ParentPage.indexNavKey]!=null)_selectedIndex=args[ParentPage.routeName]!;

      isUserCodeSet = true;
      userCode = Provider.of<UserModel>(context, listen: false).userCode;
      model = Provider.of<UserModel>(context, listen: false);
      return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Sayfam',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Fonlamalar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet),
              label: 'Portföy',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
          showUnselectedLabels: false,
        ),
      );
    } else if (loginStatus == LoginStatus.loading ||
        loginStatus == LoginStatus.notYet) {
      return const LoadingScreen();
    } else if (loginStatus == LoginStatus.wrongInfo) {
      return const LoginScreen();
    } else {
      return const ErrorScreen();
    }
  }
}
