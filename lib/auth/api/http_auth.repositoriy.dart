import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/auth/api/client/auth_api.dart';
import 'package:movie/auth/api/dto/auth_token_dto.dart';

import 'package:movie/auth/domain/auth_repository.dart';

@Singleton(as: AuthRepository)
class HttpAuthRepository implements AuthRepository {
  HttpAuthRepository(this._dio);
  final Dio _dio;

  @override
  Future<void> postSessionWithLogin(String username, String password) async {
    try {
      final token = await _dio.get(AuthApiClient.token);
      final authTokenDTO = AuthTokenDTO.fromJson(token.data);
      print(authTokenDTO.requestToken);
      final response = await _dio.post(AuthApiClient.sessionWithLogin, data: {
        "request_token": authTokenDTO.requestToken,
        'username': username,
        'password': password,
      });
      print(response);
    } on DioError catch (_) {
      rethrow;
    }
  }
}
