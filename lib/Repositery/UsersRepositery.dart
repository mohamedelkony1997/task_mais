import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_mais/Models/Users.dart';
import 'package:task_mais/consts/BaseUrl.dart';

import '../consts/colors.dart';

class UserRepository {
  static const int perPage = 6;

  static const String usersKey = 'users';

  Future<List<User>> getUsers(int page) async {
    final response = await http
        .get(Uri.parse('${BaseUrl}users?page=$page&per_page=$perPage'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['data'];
      List<User> users =
          data.map((userJson) => User.fromJson(userJson)).toList();

      // Store users in shared preferences
      await _storeUsersInSharedPreferences(users);

      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> deleteUser(int userId) async {
    final response = await http.delete(Uri.parse('${BaseUrl}users/$userId'));
    if (response.statusCode == 204) {
      Fluttertoast.showToast(
        msg: "User deleted Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: green,
        textColor: whiteColor,
        fontSize: 18.0,
      );
    }
  }

  Future<void> _storeUsersInSharedPreferences(List<User> users) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> usersJson =
        users.map((user) => jsonEncode(user.toJson())).toList();
    print(usersJson);
    prefs.setStringList(usersKey, usersJson);
  }
}
