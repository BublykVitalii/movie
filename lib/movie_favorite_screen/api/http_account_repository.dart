import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/movie/api/dto/movie_dto.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie_exceptions.dart';
import 'package:movie/movie_favorite_screen/api/client/account_api.dart';

import 'package:movie/movie_favorite_screen/api/dto/account_id_dto.dart';
import 'package:movie/movie_favorite_screen/domain/account_repository.dart';
import 'package:movie/utils/store_interaction.dart';

@Singleton(as: AccountRepository)
class HttpAccountRepository implements AccountRepository {
  HttpAccountRepository(
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
        AccountApi.account,
        queryParameters: {
          'session_id': sessionId,
        },
      );
      final accountIdDTO = AccountIdDTO.fromJson(response.data);
      _preference.setAccountId(accountIdDTO.id!);
    } catch (_) {
      return;
    }
  }

  @override
  Future<void> getFavorite(int movieId) async {
    try {
      final accountId = await _preference.getAccountId();
      final sessionId = await _preference.getSessionId();
      await _dio.post(AccountApi.getFavorite(accountId!), queryParameters: {
        'session_id': sessionId,
        "media_type": "movie",
        "favorite": true
      }, data: {
        "media_id": movieId,
      });
    } catch (_) {
      return;
    }
  }

  @override
  Future<List<Movie>> getListFavorite() async {
    try {
      final accountId = await _preference.getAccountId();
      final sessionId = await _preference.getSessionId();
      final response = await _dio.get(
        AccountApi.getListFavorite(accountId!),
        queryParameters: {'session_id': sessionId},
      );

      final movieDTO = MoviesDTO.fromJson(response.data);
      return movieDTO.toMovies();
    } on DioError catch (error) {
      if (error.response == null) {
        throw const NoResultsExceptions();
      }
      rethrow;
    }
  }
}