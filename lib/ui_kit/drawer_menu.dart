import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:movie/auth/domain/auth_service.dart';
import 'package:movie/auth/screens/auth_screen.dart';
import 'package:movie/infrastructure/movie_image.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';
import 'package:movie/movie/screens/movies_screen/movie_screen.dart';
import 'package:movie/movie_favorite_screen/screen/favorite_screen.dart';

// ---Texts---
const _kLogOut = 'Log out';
const _kFavoriteMovie = 'Favorite movie';
const _kMovie = 'Movie';

// ---Parameters---
const _kScale = 1.2;
const _kPadding = 4.0;
const _kRadius = 6.0;

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
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: AppColors.darkBlue,
                ),
                child: Image.asset(
                  MovieImage.logoImage,
                  width: double.infinity,
                  scale: _kScale,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: _kPadding,
                  right: _kPadding,
                ),
                child: TextButton(
                  onPressed: () => _onTapDrawer(FavoriteScreen.route),
                  style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.grey.shade400),
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.darkBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(_kRadius),
                      ),
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      _kFavoriteMovie,
                      style: context.theme.textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: _kPadding,
                  right: _kPadding,
                ),
                child: TextButton(
                  onPressed: () => _onTapDrawer(MovieScreen.route),
                  style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.grey.shade400),
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.darkBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(_kRadius),
                      ),
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      _kMovie,
                      style: context.theme.textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                      ),
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

  void _onTapDrawer(PageRoute route) {
    final currentRoute = ModalRoute.of(context);

    if (currentRoute?.settings.name != route.settings.name) {
      Navigator.of(context)
        ..pop()
        ..pushAndRemoveUntil<void>(route, (route) => false);
    } else {
      Navigator.of(context).pop();
    }
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
        padding: const EdgeInsets.only(left: _kPadding, right: _kPadding),
        child: TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.grey.shade400),
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
