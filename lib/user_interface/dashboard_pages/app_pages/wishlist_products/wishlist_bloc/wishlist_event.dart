import 'package:ecommerce_app/data/models/wishlist_product_model.dart';

abstract class WishlistEvent {}

class FetchAllWishlistProductEvent extends WishlistEvent {}

class AddAllWishlistProductEvent extends WishlistEvent {
  WishlistProductModel likedItem;

  AddAllWishlistProductEvent({required this.likedItem});
}

class DeleteAllWishlistProductEvent extends WishlistEvent {

  int productId;
  DeleteAllWishlistProductEvent({required this.productId});
}
