import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:movie/auth/domain/auth_service.dart';
import 'package:movie/auth/screens/auth_screen.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';
import 'package:movie/movie_favorite_screen/screen/favorite_screen.dart';

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
  final AuthService authService = GetIt.instance.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: AppColors.darkBlue,
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: double.infinity,
                  scale: _kScale,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, FavoriteScreen.route);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.shade200),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Favorite movie',
                    style: context.theme.textTheme.bodyText1!.copyWith(
                      color: AppColors.darkBlue,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _LogOutButton(authService: authService),
          ),
        ],
      ),
    );
  }
}

class _LogOutButton extends StatelessWidget {
  final AuthService authService;
  const _LogOutButton({
    Key? key,
    required this.authService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(AppColors.darkBlue),
          ),
          onPressed: () {
            authService.logOut();
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
      ),
    );
  }
}
