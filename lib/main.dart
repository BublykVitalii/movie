import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/application.dart';
import 'package:movie/auth/domain/auth_service.dart';
import 'package:movie/infrastructure/injectable.init.dart';
import 'package:movie/user/domain/user_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final getIt = GetIt.instance;

  await configureDependencies(getIt);
  final AuthService authService = getIt.get<AuthService>();
  final loggedIn = await authService.inLoggedIn();

  if (loggedIn) {
    try {
      getIt.get<UserService>().getAccountId();
    } catch (_) {
      authService.logOut();
    }
  }

  runApp(MyApp(inLoggedIn: loggedIn));
}
