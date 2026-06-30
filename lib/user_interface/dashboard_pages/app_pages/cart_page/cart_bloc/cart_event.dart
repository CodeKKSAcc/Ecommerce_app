abstract class CartEvent {}

class FetchAllCartItemEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  dynamic product_id;
  dynamic quantity;

  AddToCartEvent({
    required this.product_id,
    required this.quantity,
  });
}

class CartItemNumberEvent extends CartEvent {
  int product_id;
  int quantity;

  CartItemNumberEvent({
    required this.product_id,
    required this.quantity,
  });
}

class DeleteCartEvent extends CartEvent {

  int cart_id;

  DeleteCartEvent({required this.cart_id});
}

class OrderCartEvent extends CartEvent {

  int user_id;
  int product_id;
  int status;

  OrderCartEvent({
    this.user_id = 0,
    required this.product_id,
    this.status = 1
});
}