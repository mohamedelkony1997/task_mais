class UserModel {
  final String? updatedAt;

  UserModel({this.updatedAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(updatedAt: json['updatedAt']);
  }
}
