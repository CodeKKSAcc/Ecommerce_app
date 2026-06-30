import 'package:ecommerce_app/data/models/wishlist_product_model.dart';

abstract class WishlistState {}

class InitialWishlistState extends WishlistState {}

class LoadingWishlistState extends WishlistState {}

class LoadedWishlistState extends WishlistState {

  List<WishlistProductModel> allLikedItems;
  LoadedWishlistState({required this.allLikedItems});
}

class ErrorWishlistState extends WishlistState {

  String errorMsg;
  ErrorWishlistState({required this.errorMsg});
}
