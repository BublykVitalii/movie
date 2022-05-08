import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/movie/api/dto/movie_dto.dart';
import 'package:movie/movie_favorite/api/client/dto/favorite_data_dto.dart';
import 'package:movie/movie_favorite/api/client/favorite_movie_api.dart';
import 'package:movie/movie_favorite/domain/favorite_exceptions.dart';
import 'package:movie/movie_favorite/domain/favorite_movie_repository.dart';
import 'package:movie/utils/store_interaction.dart';

import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie_exceptions.dart';

@Singleton(as: FavoriteMovieRepository)
class HttpFavoriteMovieRepository implements FavoriteMovieRepository {
  HttpFavoriteMovieRepository(
    this._dio,
    this._preference,
  );

  final Dio _dio;
  final StoreInteraction _preference;

  @override
  Future<void> markAsFavorite(int movieId) async {
    try {
      final accountId = await _preference.getAccountId();
      final sessionId = await _preference.getSessionId();

      await _dio.post(
        FavoriteMovieApi.getFavorite(accountId!),
        queryParameters: {
          'session_id': sessionId,
        },
        data: FavoriteDataDTO(
          favorite: true,
          mediaType: MediaType.movie,
          mediaId: movieId,
        ).toJson(),
      );
    } on DioError catch (error) {
      if (error.response != null && error.response!.statusCode == 401) {
        throw const WrongAuthFailedException();
      }
      if (error.response != null && error.response!.statusCode == 404) {
        throw const WrongLinkException();
      }
    }
  }

  @override
  Future<List<Movie>> getListFavorite() async {
    try {
      final accountId = await _preference.getAccountId();
      final sessionId = await _preference.getSessionId();
      final response = await _dio.get(
        FavoriteMovieApi.getListFavorite(accountId!),
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
