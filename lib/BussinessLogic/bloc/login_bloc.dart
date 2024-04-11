import 'dart:async';


import 'package:task_mais/Repositery/LoginRepositery.dart';

class LoginBloc {
  final AuthRepository _authRepository = AuthRepository();

  final _loginStateController = StreamController<bool>();
  StreamSink<bool> get _inLogin => _loginStateController.sink;
  Stream<bool> get loginState => _loginStateController.stream;

  void login(String email, String password) async {
    try {
      final success = await _authRepository.login(email, password);

      _inLogin.add(success);
    } catch (e) {
      _inLogin.addError(e);
    }
  }

  void dispose() {
    _loginStateController.close();
  }
}
