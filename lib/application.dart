import 'package:flutter/material.dart';
import 'package:movie/auth/screens/auth_screen.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: context.theme.colorScheme.copyWith(
        primary: AppColors.darkBlue,
      ),
    );

    return MaterialApp(
      onGenerateRoute: onGenerateRoute,
      theme: theme,
    );
  }

  Route onGenerateRoute(RouteSettings? settings) {
    //return MovieScreen.route;
    return AuthScreen.route;
  }
}
