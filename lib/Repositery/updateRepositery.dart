import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_mais/Models/updatemodeluser.dart';
import 'package:task_mais/consts/BaseUrl.dart';

class UpdateUserRepository {
  Future<UserModel> updateUser(int id, String name, String job) async {
    final response = await http.put(
      Uri.parse('${BaseUrl}users/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'job': job,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return UserModel.fromJson(responseData);
    } else {
      throw Exception('Failed to update user');
    }
  }
}
