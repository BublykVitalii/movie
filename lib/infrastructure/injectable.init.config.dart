// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../config.dart' as _i4;
import '../movie/api/http_movie.repositoriy.dart' as _i6;
import '../movie/domain/movie.repository.dart' as _i5;
import 'api_client.dart' as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dioRegisterModule = _$DioRegisterModule();
  gh.singleton<_i3.Dio>(dioRegisterModule.registerClient(get<_i4.AppConfig>()));
  gh.singleton<_i5.MovieRepository>(_i6.HttpMovieRepository(get<_i3.Dio>()));
  return get;
}

class _$DioRegisterModule extends _i7.DioRegisterModule {}
