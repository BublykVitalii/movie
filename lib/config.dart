import 'package:injectable/injectable.dart';

@singleton
class AppConfig {
  static const _baseUrl = 'https://api.themoviedb.org/3';
  static const _posterUrl = 'http://image.tmdb.org/t/p/w342';
  static const _apiKey = 'ebea8cfca72fdff8d2624ad7bbf78e4c';
  static const _language = 'en-US';
  static const _avatarPath = 'https://image.tmdb.org/t/p/w150_and_h150_face';

  String get baseUrl => _baseUrl;
  String get posterUrl => _posterUrl;
  String get apiKey => _apiKey;
  String get language => _language;
  String get avatarPath => _avatarPath;

  AppConfig();
}
