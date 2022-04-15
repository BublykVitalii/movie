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
      await _dio.post(
        AuthApiClient.sessionWithLogin,
        data: authTokenDTO
            .copyWith(username: username, password: password)
            .toJson(),
      );
    } on DioError catch (error) {
      if (error.response != null && error.response!.statusCode == 401) {
        print(error);
        print(error.response);
        print(error.message);
      }

      rethrow;
    }
  }
}
