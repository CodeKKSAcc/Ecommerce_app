class ProductModel {
  dynamic id;
  String? name;
  String? price;
  String? image;
  String categoryId;
  dynamic status;
  String? createdAt;
  String? updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.categoryId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  /*ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    categoryId = json['category_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }*/
  // Factory Constructor edition ->
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'],
      price: json['price'],
      image: json['image'],
      categoryId: json['category_id'].toString(),
      status: json['status'].toString(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
