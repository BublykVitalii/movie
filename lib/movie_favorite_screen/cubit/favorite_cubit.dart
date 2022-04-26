import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:movie/movie/domain/movie.dart';
import 'package:movie/movie_favorite_screen/domain/account_service.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final Movie movie;

  FavoriteCubit(
    this.movie,
  ) : super(FavoriteInitial(movie: movie));
  AccountService get favoriteService => GetIt.instance.get<AccountService>();
}
