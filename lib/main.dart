import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/application.dart';

import 'infrastructure/injectable.init.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();

  final getIt = GetIt.instance;

  //await configureDependencies(getIt);

  runApp(const MyApp());
}
