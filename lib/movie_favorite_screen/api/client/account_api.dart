class AccountApi {
  static const account = '/account?';
  static getFavorite(int id) => '/account/$id/favorite';
  static getListFavorite(int id) => '/account/$id/favorite/movies';
}
