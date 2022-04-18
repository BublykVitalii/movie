class AuthExceptions implements Exception {}

class NoApiAuth implements Exception {
  const NoApiAuth();
  @override
  String toString() {
    return 'Wrong login or password';
  }
}

class NoApiLoading implements Exception {
  const NoApiLoading();
  @override
  String toString() {
    return 'The resource you requested was not found';
  }
}

class AccessApi implements Exception {
  const AccessApi();
  @override
  String toString() {
    return 'Access approved';
  }
}
