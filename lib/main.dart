import 'package:flutter/material.dart';
import 'package:pay_match/model/observables/user_model.dart';
import 'package:pay_match/view/screens/bottom_nav/fundings.dart';
import 'package:pay_match/view/screens/bottom_nav/home/home.dart';
import 'package:pay_match/view/screens/bottom_nav/portfolio/portfolio.dart';
import 'package:pay_match/view/screens/login.dart';
import 'package:pay_match/view/ui_tools/loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      //ChangeNotifierProvider(create: (context)=>StocksModel()),
      ChangeNotifierProvider<UserModel>(create: (context)=>UserModel(),)
    ],
    child: const MyApp()
  )
);
}


//change home if logged in maybe?
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'PayMatch';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: ParentPage(),
    );
  }
}

class ParentPage extends StatefulWidget {
  const ParentPage({super.key});

  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  int _selectedIndex = 0;
  final List<Widget> screens=[
    const HomeView(),
    FundingsView(),
    const PortfolioView()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    LoginStatus loginStatus=context.select<UserModel,LoginStatus>((model) => model.status);
    if(loginStatus==LoginStatus.success){
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
    }else if(loginStatus==LoginStatus.loading || loginStatus==LoginStatus.notYet){
      return const LoadingScreen();
    }else if(loginStatus==LoginStatus.wrongInfo){
      return const LoginScreen();
    }else {
      return const ErrorScreen();
    }
  }
}
