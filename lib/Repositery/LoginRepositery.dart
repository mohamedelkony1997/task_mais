import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task_mais/consts/BaseUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_mais/BussinessLogic/Users/users_bloc.dart';
import 'package:task_mais/Repositery/UsersRepositery.dart';

import 'package:task_mais/Ui/Home/Home.dart';
import 'package:task_mais/consts/colors.dart';

class AuthRepository {
  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${BaseUrl}login'),
      body: {
        'email': email,
        'password': password,
      },
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    final token = responseData['token'];
    if (response.statusCode == 200) {
      Get.to(
        MultiBlocProvider(providers: [
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(UserRepository()),
          ),
        ], child: HomeScreen()),
      );
      Fluttertoast.showToast(
        msg: "Login successfully at ${token}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: green,
        textColor: Colors.white,
        fontSize: 18.0,
      );
      return true;
    } else {
      final error = responseData['error'];
      Fluttertoast.showToast(
        msg: "Failed to login ${error}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: green,
        textColor: Colors.white,
        fontSize: 18.0,
      );
      throw Exception('Failed to login');
    }
  }
}
