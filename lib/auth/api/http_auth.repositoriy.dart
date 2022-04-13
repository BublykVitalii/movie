import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/auth/api/client/auth_api.dart';
import 'package:movie/auth/api/dto/auth_token_dto.dart';
import 'package:movie/auth/api/dto/user_dto.dart';
import 'package:movie/auth/domain/auth_repository.dart';
import 'package:movie/auth/domain/user.dart';

@Singleton(as: AuthRepository)
class HttpAuthRepository implements AuthRepository {
  HttpAuthRepository(this._dio);
  final Dio _dio;

  @override
  Future<AuthTokenDTO> getToken() async {
    try {
      final response = await _dio.get(AuthApiClient.token);
      final authTokenDTO = AuthTokenDTO.fromJson(response.data);
      return authTokenDTO;
    } on DioError catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> postSession() async {
    final authTokenDTO = await getToken();
    print(authTokenDTO.requestToken);
    try {
      final response = await _dio.post(AuthApiClient.session,
          data: {"request_token": authTokenDTO.requestToken});
    } on DioError catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> postSessionWithLogin(User user) async {
    try {
      final authTokenDTO = await getToken();
      print(authTokenDTO.requestToken);
      final response = await _dio.post(AuthApiClient.sessionWithLogin, data: {
        "request_token": authTokenDTO.requestToken,
        'username': user.username,
        'password': user.password,
      });
      print(response);
      // TODO:requestToken to shared Preference
    } on DioError catch (_) {
      rethrow;
    }
  }
}
