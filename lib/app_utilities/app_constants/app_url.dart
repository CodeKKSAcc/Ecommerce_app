

class AppUrl {

  static const String baseUrl = "https://ecomapi.projectnest.co.in/ecommerce-api";

  static const String loginUrl = "$baseUrl/user/login";
  static const String signupUrl = "$baseUrl/user/registration";
  static const String getProductsUrl = "$baseUrl/products";
  static const String categoryProductsUrl = "$baseUrl/categories";
  static const String userProfileUrl = "$baseUrl/user/profile";
  static const String createOrderUrl = "$baseUrl/product/create-order";
  static const String getOrderUrl = "$baseUrl/product/get-order";
  static const String addToCartUrl = "$baseUrl/add-to-cart";
  static const String viewCartUrl = "$baseUrl/product/view-cart";
  static const String decrementCartItemQuantity = "$baseUrl/product/decrement-quantity";
  static const String deleteCart = "$baseUrl/product/delete-cart";
}