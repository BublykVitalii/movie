import 'package:flutter/material.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';

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
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.darkBlue,
            ),
            child: Image.asset(
              'assets/images/logo.png',
              scale: 1.2,
            ),
          ),
          ListTile(
            title: const Text(
              'Now playing',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {},
          ),
          Container(
            height: 2,
            color: Colors.grey.shade200,
          ),
        ],
      ),
    );
  }
}
