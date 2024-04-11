// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_mais/BussinessLogic/Users/cruds/updateUser.dart';
import 'package:task_mais/Repositery/UsersRepositery.dart';
import 'package:task_mais/Repositery/updateRepositery.dart';

import 'package:task_mais/consts/colors.dart';
import 'package:task_mais/consts/strings.dart';
class UpdateUserDialog extends StatelessWidget {
  final String name;
  final String email;
  final int id;

  UpdateUserDialog(this.name, this.email, this.id);

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = name;
    _emailController.text = email;

    return BlocProvider(
      create: (context) => UpdateUserBloc(UpdateUserRepository()),
      child: AlertDialog(
        title: Text('Update User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.person,
                    color: darkFontGrey,
                  ),
                ),
                hintText: 'Enter name',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 7.0),
                filled: true,
                fillColor: textfieldGrey,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.email,
                    color: darkFontGrey,
                  ),
                ),
                hintText: 'Enter email',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 7.0),
                filled: true,
                fillColor: textfieldGrey,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: redColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: whiteColor, fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: () {
                final userBloc = BlocProvider.of<UpdateUserBloc>(context);
                userBloc.updateUser(
                  id,
                  _nameController.text,
                  _emailController.text,
                );
                userBloc.stream.listen((event) {
                  if (event.updatedAt != null) {
                    Fluttertoast.showToast(
                      msg: "User Updated successfully at ${event.updatedAt}",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: green,
                      textColor: Colors.white,
                      fontSize: 18.0,
                    );
                  }
                });
              },
              child: Text(
                'Update',
                style: TextStyle(color: whiteColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
