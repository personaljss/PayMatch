import 'package:flutter/material.dart';

import '../../ui_tools/nav_drawer.dart';

class FundingsView extends StatefulWidget {
  const FundingsView({Key? key}) : super(key: key);

  @override
  State<FundingsView> createState() => _FundingsViewState();
}

class _FundingsViewState extends State<FundingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("fonlamalar"),
      ),
      drawer: const MyDrawer(),
    );
  }
}
