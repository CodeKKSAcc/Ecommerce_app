class OrderProductModel {
  int id; // Product Id
  String name;
  int quantity;
  String price;
  String image;

  OrderProductModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      id: json["id"],
      name: json["name"],
      quantity: json["quantity"],
      price: json["price"],
      image: json["image"],
    );
  }
}

class OrderModel {
  int id; // User Id
  String total_amount;
  String order_number;
  String status;
  String created_at;
  List<OrderProductModel> product;

  OrderModel({
    required this.id,
    required this.total_amount,
    required this.order_number,
    required this.status,
    required this.created_at,
    required this.product,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {

    List<OrderProductModel> allProduct = [];

    for (Map<String, dynamic> data in json["product"]) {
      allProduct.add(OrderProductModel.fromJson(data));
    }

    return OrderModel(
      id: json["id"],
      total_amount: json["total_amount"],
      order_number: json["order_number"],
      status: json["status"],
      created_at: json["created_at"],
      product: allProduct,
    );
  }
}
