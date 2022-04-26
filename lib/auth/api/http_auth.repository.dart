import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/auth/api/client/auth_api.dart';
import 'package:movie/auth/api/dto/auth_token_dto.dart';
import 'package:movie/auth/api/dto/session_id_dto.dart';
import 'package:movie/auth/domain/auth_exceptions.dart';

import 'package:movie/auth/domain/auth_repository.dart';
import 'package:movie/utils/store_interaction.dart';

@Singleton(as: AuthRepository)
class HttpAuthRepository implements AuthRepository {
  HttpAuthRepository(this._dio, this._preference);

  final Dio _dio;
  final StoreInteraction _preference;

  @override
  Future<void> sessionWithLogin(String username, String password) async {
    try {
      final token = await _dio.get(AuthApiClient.token);
      final authTokenDTO = AuthTokenDTO.fromJson(token.data);

      await _dio.post(
        AuthApiClient.sessionWithLogin,
        data: authTokenDTO
            .copyWith(username: username, password: password)
            .toJson(),
      );

      final response = await _dio.post(
        AuthApiClient.session,
        data: {
          'request_token': authTokenDTO.requestToken,
        },
      );
      final sessionIdDTO = SessionIdDTO.fromJson(response.data);

      _preference.setSessionId(sessionIdDTO.sessionId);
    } on DioError catch (error) {
      if (error.response != null && error.response!.statusCode == 401) {
        throw const WrongCredentialsException();
      }
      if (error.response != null && error.response!.statusCode == 404) {
        throw const WrongLinkException();
      }

      rethrow;
    }
  }

  @override
  Future<bool> inLoggedIn() async {
    final sessionId = await _preference.getSessionId();
    return sessionId != null;
  }

  @override
  Future<void> logOut() async {
    await _preference.removeSessionId();
  }
}
