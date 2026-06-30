class UserProfileDataModel {
  String id;
  String name;
  String email;
  String mobile_number;
  String password;
  String? image;
  String status;
  String created_at;
  String updated_at;

  UserProfileDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile_number,
    required this.password,
    required this.image,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  factory UserProfileDataModel.fromJson(Map<String, dynamic> json) {
    return UserProfileDataModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      mobile_number: json["mobile_number"],
      password: json["password"],
      image: json["image"],
      status: json["status"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
    );
  }
}
