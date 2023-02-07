import 'package:flutter/material.dart';
import 'package:pay_match/model/observables/stocks_model.dart';
import 'package:pay_match/view/screens/bottom_nav/fundings.dart';
import 'package:pay_match/view/screens/bottom_nav/fav_stocks.dart';
import 'package:pay_match/view/screens/bottom_nav/portfolio/portfolio.dart';
import 'package:provider/provider.dart';


void main() => runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>StocksModel())
    ],
    child: const MyApp()
  )
);


//change home if logged in maybe?
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
    const FavsView(),
    const FundingsView(),
    const PortfolioView()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) =>Scaffold(
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
            icon: Icon(Icons.school),
            label: 'Portföy',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        showUnselectedLabels: false,
      ),
    );
}
