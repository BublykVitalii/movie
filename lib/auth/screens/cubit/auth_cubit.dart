import 'package:get_it/get_it.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/auth/domain/auth_exceptions.dart';
import 'package:movie/auth/domain/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());
  AuthService get authService => GetIt.instance.get<AuthService>();

  Future<void> postSessionWithLogin(String username, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await authService.postSessionWithLogin(username, password);
      emit(state.copyWith(status: AuthStatus.success));
    } on NoApiAuth catch (error) {
      emit(state.copyWith(
        status: AuthStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
