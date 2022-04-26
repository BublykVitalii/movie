import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie/domain/movie.dart';

import 'package:movie/movie_favorite_screen/domain/account_service.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  AccountService get accountService => GetIt.instance.get<AccountService>();

  void getFavorite() async {
    emit(FavoriteLoading());
    try {
      final listMovies = await accountService.getListFavorite();

      emit(FavoriteSuccess(listMovies: listMovies));
    } catch (e) {
      emit(FavoriteError());
    }
  }
}
