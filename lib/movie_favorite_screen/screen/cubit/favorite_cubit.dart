import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie_favorite_screen/domain/favorite_exceptions.dart';

import 'package:movie/movie_favorite_screen/domain/favorite_service.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState());
  FavoriteService get accountService => GetIt.instance.get<FavoriteService>();

  void getFavorite() async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    try {
      final listMovies = await accountService.getListFavorite();
      emit(state.copyWith(
        status: FavoriteStatus.success,
        listMovies: listMovies,
      ));
    } on WrongAuthFailedException catch (error) {
      emit(state.copyWith(
        status: FavoriteStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
