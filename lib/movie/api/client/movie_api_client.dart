class MovieApiClient {
  static const _movie = '/movie';
  static const _nowPlaying = '/now_playing';
  static const nowPlaying = '$_movie$_nowPlaying';
  static const popular = '$_movie/popular';
  static const topRated = '$_movie//top_rated';
  static const upcoming = '$_movie/upcoming';
  static getMovieById(int id) => '$_movie/$id';
}
