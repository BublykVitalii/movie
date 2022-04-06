import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/movie/api/client/movie_api_client.dart';
import 'package:movie/movie/api/dto/movie_dto.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie.repository.dart';

@Singleton(as: MovieRepository)
class HttpMovieRepository implements MovieRepository {
  HttpMovieRepository(this._dio);
  final Dio _dio;

  @override
  Future<List<Movie>> getNowPlaying(int page) async {
    try {
      final response = await _dio.get(MovieApiClient.nowPlaying);
      final movieDTO = MoviesDTO.fromJson(response.data);
      return movieDTO.toMovies();
    } on DioError catch (_) {
      rethrow;
    }
  }

  @override
  Future<Movie> getMovieById(int id) async {
    try {
      final response = await _dio.get(MovieApiClient.getMovieById(id));
      final movieDTO = MovieDTO.fromJson(response.data);
      return movieDTO.toMovie();
    } on DioError catch (_) {
      rethrow;
    }
  }
}
