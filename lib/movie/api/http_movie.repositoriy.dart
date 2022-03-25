import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/movie/api/client/movie_api_client.dart';
import 'package:movie/movie/api/dto/movie_dto.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie.repository.dart';
import 'package:movie/movie/screens/cubit/movie_state.dart';

@Singleton(as: MovieRepository)
class HttpMovieRepository implements MovieRepository {
  HttpMovieRepository(this._dio);
  final Dio _dio;

  @override
  Future<List<Movie>> getNowPlaying() async {
    try {
      final response = await _dio.get(MovieApiClient.nowPlaying);
      final movieDTO = MoviesDTO.fromJson(response.data);
      return movieDTO.toMovies();
    } on MovieError catch (_) {
      rethrow;
    }
  }
}
