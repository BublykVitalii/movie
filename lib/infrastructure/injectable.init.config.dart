// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../auth/api/http_auth.repository.dart' as _i13;
import '../auth/domain/auth_repository.dart' as _i12;
import '../auth/domain/auth_service.dart' as _i14;
import '../config.dart' as _i3;
import '../movie/api/http_movie.repository.dart' as _i6;
import '../movie/domain/movie.repository.dart' as _i5;
import '../movie/domain/movie_service.dart' as _i7;
import '../movie_favorite_screen/api/http_account_repository.dart' as _i10;
import '../movie_favorite_screen/domain/account_repository.dart' as _i9;
import '../movie_favorite_screen/domain/account_service.dart' as _i11;
import '../utils/store_interaction.dart' as _i8;
import 'api_client.dart' as _i15; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dioRegisterModule = _$DioRegisterModule();
  gh.singleton<_i3.AppConfig>(_i3.AppConfig());
  gh.singleton<_i4.Dio>(dioRegisterModule.registerClient(get<_i3.AppConfig>()));
  gh.singleton<_i5.MovieRepository>(_i6.HttpMovieRepository(get<_i4.Dio>()));
  gh.singleton<_i7.MovieService>(_i7.MovieService(get<_i5.MovieRepository>()));
  gh.singleton<_i8.StoreInteraction>(_i8.StoreInteraction());
  gh.singleton<_i9.AccountRepository>(
      _i10.HttpAccountRepository(get<_i4.Dio>(), get<_i8.StoreInteraction>()));
  gh.singleton<_i11.AccountService>(
      _i11.AccountService(get<_i9.AccountRepository>()));
  gh.singleton<_i12.AuthRepository>(
      _i13.HttpAuthRepository(get<_i4.Dio>(), get<_i8.StoreInteraction>()));
  gh.singleton<_i14.AuthService>(_i14.AuthService(get<_i12.AuthRepository>()));
  return get;
}

class _$DioRegisterModule extends _i15.DioRegisterModule {}
