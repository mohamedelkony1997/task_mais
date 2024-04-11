import 'package:bloc/bloc.dart';
import 'package:task_mais/BussinessLogic/Users/users_event.dart';
import 'package:task_mais/BussinessLogic/Users/users_state.dart';
import 'package:task_mais/Models/Users.dart';
import 'package:task_mais/Repositery/UsersRepositery.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      if (state is! UserLoading) {
        emit(UserLoading());
        try {
          final List<User> users = await userRepository.getUsers(1); // Fetch the first page initially
          emit(UserLoaded(users));
        } catch (e) {
          emit(UserError(e.toString()));
        }
      }
    });

    on<FetchUsersPage>((event, emit) async {
      if (state is! UserLoading) {
        emit(UserLoading());
        try {
          final List<User> users = await userRepository.getUsers(event.page);
          emit(UserLoaded(users));
        } catch (e) {
          emit(UserError(e.toString()));
        }
      }
    });

    on<DeleteUser>((event, emit) async {
      emit(UserLoading());
      try {
        // Call the repository method to delete the user
        await userRepository.deleteUser(event.userId);
        // Re-fetch users after deletion
        final List<User> users = await userRepository.getUsers(1);
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
