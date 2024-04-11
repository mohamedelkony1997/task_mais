class AddUserResponse {
  late final String id;
  late final String createdAt;

  AddUserResponse({required this.id, required this.createdAt});

  factory AddUserResponse.fromJson(Map<String, dynamic> json) {
    return AddUserResponse(
      id: json['id'],
      createdAt: json['createdAt'],
    );
  }
}
