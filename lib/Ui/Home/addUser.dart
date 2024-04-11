import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_mais/BussinessLogic/Users/cruds/add_bloc.dart';
import 'package:task_mais/consts/colors.dart';
import 'package:task_mais/consts/strings.dart';

class AddUserDialog extends StatefulWidget {
  @override
  _AddUserDialogState createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add User'),
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
              hintText: fname + "  " + lname,
              hintStyle: TextStyle(color: fontGrey),
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
            controller: _jobController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.work,
                  color: darkFontGrey,
                ),
              ),
              hintText: jop,
              hintStyle: TextStyle(color: fontGrey, fontSize: 16),
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
              color: redColor, borderRadius: BorderRadius.circular(20)),
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
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
              color: green, borderRadius: BorderRadius.circular(20)),
          child: TextButton(
            onPressed: () {
              final name = _nameController.text;
              final job = _jobController.text;
              userBloc.addUser(name, job);
              Navigator.of(context).pop();
            },
            child: Text('Add',  style: TextStyle(color: whiteColor, fontSize: 16),),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    userBloc.responseStream.listen((response) {
      if (response != null) {
        Fluttertoast.showToast(
          msg: "User Created successfully at ${response.createdAt}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: green,
          textColor: Colors.white,
          fontSize: 18.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to create user",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18.0,
        );
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobController.dispose();
    super.dispose();
  }
}
