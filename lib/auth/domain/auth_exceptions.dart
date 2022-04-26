class WrongCredentialsException implements Exception {
  const WrongCredentialsException();
  @override
  String toString() {
    return 'Wrong login or password';
  }
}

class WrongLinkException implements Exception {
  const WrongLinkException();
  @override
  String toString() {
    return 'The resource you requested was not found';
  }
}
