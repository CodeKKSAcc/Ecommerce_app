import 'package:ecommerce_app/data/app_helper/database_helper.dart';

class WishlistProductModel {
  int? id;
  String image;
  String name;
  double price;
  int productId;
  bool isLiked;

  WishlistProductModel({
    required this.image,
    required this.name,
    required this.price,
    required this.productId,
    this.isLiked = false,
  });

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.column_product_image: image,
      DatabaseHelper.column_product_name: name,
      DatabaseHelper.column_product_price: price,
      DatabaseHelper.column_product_id: productId,
      DatabaseHelper.column_product_liked: isLiked ? 1 : 0,
    };
  }

  factory WishlistProductModel.fromMap(Map<String, dynamic> myMap) {
    return WishlistProductModel(
      image: myMap[DatabaseHelper.column_product_image],
      name: myMap[DatabaseHelper.column_product_name],
      price: myMap[DatabaseHelper.column_product_price],
      productId: myMap[DatabaseHelper.column_product_id],
      isLiked: myMap[DatabaseHelper.column_product_liked] == 1 ? true : false
    );
  }
}
