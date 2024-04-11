// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mais/BussinessLogic/Users/cruds/updateUser.dart';
import 'package:task_mais/BussinessLogic/Users/users_bloc.dart';
import 'package:task_mais/BussinessLogic/Users/users_event.dart';
import 'package:task_mais/BussinessLogic/Users/users_state.dart';
import 'package:task_mais/Models/Users.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:task_mais/Repositery/updateRepositery.dart';
import 'package:task_mais/Ui/Home/addUser.dart';
import 'package:task_mais/Ui/Home/updateUser.dart';
import 'package:task_mais/consts/colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(FetchUsers());
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final User user = state.users[index];
                return InkWell(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        userBloc.add(DeleteUser(user.id));
                      },
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => BlocProvider(
                        create: (context) =>
                            UpdateUserBloc(UpdateUserRepository()),
                        child: UpdateUserDialog(
                            user.firstName + ' ' + user.lastName,
                            user.email,
                            user.id),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is UserError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else {
            return Center(
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return NumberPagination(
              onPageChanged: (int page) {
                userBloc.add(FetchUsersPage(page));
              },
              pageTotal: 2,
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: green,
        ),
        child: IconButton(
          icon: Icon(
            Icons.add,
            color: whiteColor,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AddUserDialog(), // Show your dialog here
            );
          },
        ),
      ),
    );
  }
}
