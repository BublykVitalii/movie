import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:movie/auth/screens/auth_screen.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';
import 'package:movie/utils/store_interaction.dart';

// ---Texts---
const _kLogOut = 'Log out';

// ---Parameters---
const _kScale = 1.2;

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  StoreInteraction get _preference => GetIt.instance.get<StoreInteraction>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.darkBlue,
            ),
            child: Padding(
              padding: EdgeInsets.zero,
              child: Image.asset(
                'assets/images/logo.png',
                width: double.infinity,
                scale: _kScale,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.zero,
              children: [
                LogOutButton(preference: _preference),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  final StoreInteraction preference;
  const LogOutButton({
    Key? key,
    required this.preference,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(AppColors.darkBlue),
        ),
        onPressed: () {
          preference.removeSessionId();
          Navigator.pushReplacement(context, AuthScreen.route);
        },
        child: Text(
          _kLogOut,
          style: context.theme.textTheme.bodyText1!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
