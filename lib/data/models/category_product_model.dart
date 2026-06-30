class CategoryProductModel {
  dynamic id; // Product Id
  String name;
  dynamic status;
  String created_at;
  String updated_at;

  CategoryProductModel({
    required this.id,
    required this.name,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  factory CategoryProductModel.fromJson(Map<String, dynamic> json) {
    return CategoryProductModel(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
    );
  }
}
