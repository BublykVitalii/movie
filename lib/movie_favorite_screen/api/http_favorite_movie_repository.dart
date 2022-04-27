import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/movie/api/dto/movie_dto.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie_exceptions.dart';
import 'package:movie/movie_favorite_screen/api/client/dto/favorite_data_dto.dart';
import 'package:movie/movie_favorite_screen/api/client/favorite_movie_api.dart';
import 'package:movie/movie_favorite_screen/domain/favorite_movie_repository.dart';
import 'package:movie/user/domain/user_service.dart';
import 'package:movie/utils/store_interaction.dart';

@Singleton(as: FavoriteMovieRepository)
class HttpFavoriteMovieRepository implements FavoriteMovieRepository {
  HttpFavoriteMovieRepository(
    this._dio,
    this._preference,
  );

  final Dio _dio;
  final StoreInteraction _preference;

  UserService get userService => GetIt.instance.get<UserService>();

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
    } catch (_) {
      return;
    }
  }

  @override
  Future<List<Movie>> getListFavorite() async {
    try {
      userService.getAccountId();
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
