import 'package:injectable/injectable.dart';

@singleton
class AppConfig {
  static const _baseUrl = 'https://api.themoviedb.org/3/movie';
  String get baseUrl => _baseUrl;
}
