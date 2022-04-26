import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/application.dart';
import 'package:movie/auth/domain/auth_service.dart';
import 'package:movie/infrastructure/injectable.init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final getIt = GetIt.instance;

  await configureDependencies(getIt);
  AuthService authService = GetIt.instance.get<AuthService>();
  final loggedIn = await authService.inLoggedIn();

  runApp(MyApp(inLoggedIn: loggedIn));
}
