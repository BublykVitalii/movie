import 'package:injectable/injectable.dart';

@singleton
class AppConfig {
  static const _baseUrl = 'https://api.themoviedb.org/3';
  static const _apiKey = 'ebea8cfca72fdff8d2624ad7bbf78e4c';
  static const _language = 'en-US';

  String get baseUrl => _baseUrl;
  String get apiKey => _apiKey;
  String get language => _language;

  AppConfig();
}
