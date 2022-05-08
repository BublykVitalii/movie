part of 'auth_cubit.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  error,
}

class AuthState {
  final AuthStatus status;
  final String? errorMessage;

  AuthState({
    this.errorMessage,
    this.status = AuthStatus.initial,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'AuthState {  status: $status, errorMessage: $errorMessage';
  }

  List<Object?> get props => [
        status,
        errorMessage,
      ];
}
