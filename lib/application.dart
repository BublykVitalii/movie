import 'package:flutter/material.dart';
import 'package:movie/infrastructure/theme/app_colors.dart';
import 'package:movie/infrastructure/theme/theme_extensions.dart';
import 'package:movie/movie/screens/movies_screen/movie_screen.dart';

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
    return MovieScreen.route;
    // return MovieAuthentication.route;
  }
}
