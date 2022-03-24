import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/movie/api/dto/movie_dto.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie.repository.dart';
import 'package:movie/movie/screens/cubit/movie_state.dart';

@Singleton(as: MovieRepository)
class HttpMovieRepository implements MovieRepository {
  HttpMovieRepository(this._dio);
  final Dio _dio;

  void getHttp() async {
    try {
      var response = await Dio(
        BaseOptions(
          baseUrl: 'https://api.themoviedb.org/3',
          queryParameters: {
            'api_key': 'ebea8cfca72fdff8d2624ad7bbf78e4c',
            'language': 'en-US',
          },
        ),
      ).get('/movie/now_playing?');
      print(response.requestOptions.baseUrl);
    } catch (e) {
      print(e);
    }
  }

  Future<Movie> getMovieNowPlaying() async {
    try {
      final response = await _dio.get(
          'http://api.themoviedb.org/3/movie/now_playing?api_key=ebea8cfca72fdff8d2624ad7bbf78e4c');
      final movieDTO = MovieDTO.fromJason(response.data);
      return movieDTO.toMovie();
    } on MovieError catch (_) {
      rethrow;
    }
  }
}
