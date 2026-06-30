import 'package:ecommerce_app/data/models/cart_product_model.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  String successMsg;
  CartSuccessState({required this.successMsg});
}

class CartLoadedState extends CartState {

  List<CartProductModel> allProductsInCart;
  CartLoadedState({required this.allProductsInCart});
}

class CartFailureState extends CartState {
  String errorMsg;

  CartFailureState({required this.errorMsg});
}