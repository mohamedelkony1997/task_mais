import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mais/Models/updatemodeluser.dart';
import 'package:task_mais/Repositery/updateRepositery.dart';


class UpdateUserBloc extends Cubit<UserModel> {
  final UpdateUserRepository userRepository;

  UpdateUserBloc(this.userRepository) : super(UserModel());

  Future<void> updateUser(int id, String name, String job) async {
    try {
      final updatedUser = await userRepository.updateUser(id, name, job);
      emit(updatedUser);
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }
}
