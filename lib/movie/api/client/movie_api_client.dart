class MovieApiClient {
  static const _nowPlaying = '/now_playing';
  static const _apiKey = 'ebea8cfca72fdff8d2624ad7bbf78e4c';
  static const movieNowPlaying = '$_nowPlaying?api_key=$_apiKey&language=en-US';
  static page(int number) => '$movieNowPlaying&$number';
}
