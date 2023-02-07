import 'package:flutter/material.dart';

import '../screens/drawer_nav/about_us.dart';
import '../screens/drawer_nav/notifications.dart';
import '../screens/drawer_nav/settings.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  void _goToAboutUs(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const AboutUs()));
  }

  void _goToSettings(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Settings()));
  }

  void _goToNotifications(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Notifications()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Hakkımızda'),
              onTap: ()=>_goToAboutUs(context)
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Bildirimler"),
            onTap: ()=>_goToNotifications(context),
          ),
          ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ayarlar'),
              onTap: ()=>_goToSettings(context)
          ),
        ],
      ),
    );
  }
}
