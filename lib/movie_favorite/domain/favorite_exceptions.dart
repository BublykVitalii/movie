class WrongAuthFailedException implements Exception {
  const WrongAuthFailedException();
  @override
  String toString() {
    return 'Authentication failed';
  }
}

class WrongLinkException implements Exception {
  const WrongLinkException();
  @override
  String toString() {
    return 'The resource you requested was not found';
  }
}
