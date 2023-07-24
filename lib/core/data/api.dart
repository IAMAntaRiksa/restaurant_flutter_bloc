class Api {
  static const _baseServer = "http://103.150.116.14:1337/api";

  String getRestaurants = "$_baseServer/restaurants";
  String getRestaurant = "$_baseServer/restaurants";
  String loginResturant = "$_baseServer/auth/local";
  String registerResturant = "$_baseServer/auth/local/register";
  String getUserById = "$_baseServer/restaurants?filters[userId]";
  String createRestaurant = "$_baseServer/restaurants";
  String uploadImageRestaurant = "$_baseServer/upload";
}
