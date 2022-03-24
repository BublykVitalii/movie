import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/config.dart';

class FlutterTransformer extends DefaultTransformer {
  static dynamic _parseAndDecode(String response) {
    return jsonDecode(response);
  }

  static Future _parseJson(String text) {
    return compute(_parseAndDecode, text);
  }

  FlutterTransformer() : super(jsonDecodeCallback: _parseJson);
}

@module
abstract class DioRegisterModule {
  @singleton
  Dio registerClient(AppConfig config) {
    return Dio(
      BaseOptions(baseUrl: config.baseUrl),
    )..transformer = FlutterTransformer();
  }
}
