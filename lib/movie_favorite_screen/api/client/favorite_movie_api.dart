class FavoriteMovieApi {
  static getFavorite(int id) => '/account/$id/favorite';
  static getListFavorite(int id) => '/account/$id/favorite/movies';
}
