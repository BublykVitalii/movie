import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie/domain/movie.dart';

import 'package:movie/movie_favorite_screen/domain/favorite_service.dart';
import 'package:movie/movie_favorite_screen/domain/favorite_exceptions.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  FavoriteService get accountService => GetIt.instance.get<FavoriteService>();

  void getFavorite() async {
    emit(FavoriteLoading());
    try {
      final listMovies = await accountService.getListFavorite();

      emit(FavoriteSuccess(listMovies: listMovies));
    } on DioError catch (error) {
      if (error.response != null && error.response!.statusCode == 401) {
        throw const WrongAuthException();
      }
      if (error.response != null && error.response!.statusCode == 404) {
        throw const WrongLinkException();
      }

      rethrow;
    }
  }
}
