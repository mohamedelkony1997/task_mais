import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_mais/Models/Users.dart';
import 'package:task_mais/consts/BaseUrl.dart';

import '../consts/colors.dart';

class UserRepository {
  static const int perPage = 6;
   SharedPreferences? _prefs;



  Future<List<User>> getUsers(int page) async {
    // Check if users are stored locally
    final String? usersJson = _prefs!.getString('users');
    if (usersJson != null) {
      final List<dynamic> data = jsonDecode(usersJson);
      return data.map((userJson) => User.fromJson(userJson)).toList();
    } else {
      final response = await http.get(Uri.parse('${BaseUrl}users?page=$page&per_page=$perPage'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> data = jsonData['data'];
          _prefs = await SharedPreferences.getInstance();
        // Save users locally
        await _prefs!.setString('users', jsonEncode(data));
        return data.map((userJson) => User.fromJson(userJson)).toList();
      } else {
        throw Exception('Failed to load users');
      }
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
      // After successful deletion, update locally stored users
      final List<User> users = await getUsers(1);
      await _prefs!.setString('users', jsonEncode(users));
    }
  }
}
