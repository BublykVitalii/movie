class MovieApiClient {
  static const _movie = '/movie';
  static const _nowPlaying = '/now_playing';
  static const nowPlaying = '$_movie$_nowPlaying';
  static getMovieById(int id) => '$_movie/$id';
  static getMovieCertification() => '/certification/$_movie';
}
