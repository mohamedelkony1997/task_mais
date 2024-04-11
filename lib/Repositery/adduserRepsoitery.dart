import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_mais/Models/addUser.dart';
import 'package:task_mais/consts/BaseUrl.dart';

// Import your model class

class AddUserRepository {
  static Future<AddUserResponse> addUser(String name, String job) async {
    final response = await http.post(
      Uri.parse('${BaseUrl}users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'job': job,
      }),
    );

    if (response.statusCode == 201) {
      return AddUserResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add user');
    }
  }
}
