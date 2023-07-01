class Api {
  static const _baseServer = "http://103.150.116.14:1337/api";

  String getRestaurants = "$_baseServer/restaurants";
  String loginResturant = "$_baseServer/auth/local";
  String registerResturant = "$_baseServer/auth/local/register";
}
