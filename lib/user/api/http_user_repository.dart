import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/user/api/client/user_api.dart';
import 'package:movie/user/api/dto/user_dto.dart';
import 'package:movie/user/domain/user_repository.dart';
import 'package:movie/utils/store_interaction.dart';

@Singleton(as: UserRepository)
class HttpUserRepository implements UserRepository {
  HttpUserRepository(
    this._dio,
    this._preference,
  );

  final Dio _dio;
  final StoreInteraction _preference;

  @override
  Future<void> getAccountId() async {
    try {
      final sessionId = await _preference.getSessionId();
      final response = await _dio.get(
        UserApi.account,
        queryParameters: {
          'session_id': sessionId,
        },
      );
      final accountIdDTO = UserDTO.fromJson(response.data);
      _preference.setAccountId(accountIdDTO.id);
    } catch (_) {
      return;
    }
  }
}
