import 'package:flutter/material.dart';

import 'movie/screens/movie_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color.fromRGBO(5, 38, 64, 1),
        ),
      ),
    );
  }

  Route onGenerateRoute(RouteSettings? settings) {
    return MovieScreen.route;
  }
}
