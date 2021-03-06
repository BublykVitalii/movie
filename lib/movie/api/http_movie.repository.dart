import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:movie/movie/api/client/movie_api_client.dart';
import 'package:movie/movie/api/dto/movie_dto.dart';
import 'package:movie/movie/api/dto/page_dto.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie/domain/movie.repository.dart';
import 'package:movie/movie/domain/movie_exceptions.dart';

@Singleton(as: MovieRepository)
class HttpMovieRepository implements MovieRepository {
  HttpMovieRepository(
    this._dio,
  );
  final Dio _dio;

  @override
  Future<List<Movie>> getNowPlaying(int page) async {
    try {
      final pageDTO = PageDTO(page: page);
      final response = await _dio.get(
        MovieApiClient.nowPlaying,
        queryParameters: pageDTO.toJson(),
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

  @override
  Future<List<Movie>> getPopular(int page) async {
    try {
      final pageDTO = PageDTO(page: page);
      final response = await _dio.get(
        MovieApiClient.popular,
        queryParameters: pageDTO.toJson(),
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

  @override
  Future<List<Movie>> getTopRated(int page) async {
    try {
      final pageDTO = PageDTO(page: page);
      final response = await _dio.get(
        MovieApiClient.topRated,
        queryParameters: pageDTO.toJson(),
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

  @override
  Future<List<Movie>> getUpcoming(int page) async {
    try {
      final pageDTO = PageDTO(page: page);
      final response = await _dio.get(
        MovieApiClient.upcoming,
        queryParameters: pageDTO.toJson(),
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
