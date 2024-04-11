import 'dart:async';

import 'package:task_mais/Models/addUser.dart';
import 'package:task_mais/Repositery/adduserRepsoitery.dart';

class addUserBloc {
  final _responseController = StreamController<AddUserResponse>();

  Stream<AddUserResponse> get responseStream => _responseController.stream;

  void addUser(String name, String job) async {
    final response = await AddUserRepository.addUser(name, job);
    _responseController.sink.add(response);
  }

  void dispose() {
    _responseController.close();
  }
}

final userBloc = addUserBloc();
