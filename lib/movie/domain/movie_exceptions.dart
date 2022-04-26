class NoResultsExceptions implements Exception {
  const NoResultsExceptions();

  @override
  String toString() {
    return 'No internet connection';
  }
}
