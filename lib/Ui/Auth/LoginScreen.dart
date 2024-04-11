// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:task_mais/BussinessLogic/bloc/login_bloc.dart';

import 'package:task_mais/consts/colors.dart';
import 'package:task_mais/consts/strings.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailCon = TextEditingController();

  TextEditingController passwordCon = TextEditingController();

  bool isSeen = true;

  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 2, left: 2),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        acount_login,
                        style: TextStyle(
                            color: darkFontGrey,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Center(
                    child: Image(
                  image: AssetImage("assets/images/login.png"),
                  width: 280,
                  height: 230,
                )),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    email,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: darkFontGrey,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailCon,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.email_outlined,
                        color: darkFontGrey,
                      ),
                    ),
                    hintText: emailHint,
                    hintStyle: TextStyle(color: fontGrey),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 7.0),
                    filled: true,
                    fillColor: textfieldGrey,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    password,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: darkFontGrey,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordCon,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.password,
                          color: darkFontGrey,
                        ),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isSeen = !isSeen;
                          });
                        },
                        child: Icon(
                            isSeen ? Icons.visibility_off : Icons.visibility),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 6.0),
                      hintText: "$password",
                      hintStyle: TextStyle(color: fontGrey),
                      filled: true,
                      fillColor: textfieldGrey),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  obscureText: isSeen,
                ),
                SizedBox(
                  height: 65,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(300, 50)),
                    backgroundColor: MaterialStateProperty.all(green),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _loginBloc.login(emailCon.text, passwordCon.text);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      login,
                      style: TextStyle(fontSize: 18, color: whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
