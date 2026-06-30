class CartProductModel {
  int id;
  int product_id;
  String name;
  String price;
  int quantity;
  String image;

  CartProductModel({
    required this.id,
    required this.product_id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      id: json["id"],
      product_id: json["product_id"],
      name: json["name"],
      price: json["price"],
      quantity: json["quantity"],
      image: json["image"],
    );
  }
}
