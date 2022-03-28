import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
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
            title: const Text('User'),
            onTap: () {},
          ),
          Container(
            height: 2,
            color: Colors.grey.shade200,
          ),
          ListTile(
            title: const Text('Cars'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // void _onTapDrawer(PageRoute route) {
  //   final currentRoute = ModalRoute.of(context);

  //   if (currentRoute?.settings.name != route.settings.name) {
  //     Navigator.of(context)
  //       ..pop()
  //       ..pushAndRemoveUntil<void>(route, (route) => false);
  //   } else {
  //     Navigator.of(context).pop();
  //   }
  // }
}
