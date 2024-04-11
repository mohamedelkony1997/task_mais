import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:task_mais/Models/Users.dart';
import 'package:task_mais/Repositery/UsersRepositery.dart';
import 'package:task_mais/consts/BaseUrl.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('UserRepository', () {
    final mockClient = MockClient();
    final userRepository = UserRepository();

    test('getUsers - Success', () async {
      final jsonData = {
        'data': [{'id': 1, 'name': 'John'}, {'id': 2, 'name': 'Jane'}]
      };
      when(mockClient.get(Uri.parse('${BaseUrl}users?page=1&per_page=6')))
          .thenAnswer((_) async => http.Response(jsonEncode(jsonData), 200));

      final users = await userRepository.getUsers(1);

      expect(users.length, 2);
      expect(users[0].id, 1);
      expect(users[0].firstName, 'John'); // Assuming User has a name property
      expect(users[1].id, 2);
      expect(users[1].lastName, 'Jane'); // Assuming User has a name property
    });

    test('deleteUser - Success', () async {
      final userId = 1;
      when(mockClient.delete(Uri.parse('${BaseUrl}users/$userId')))
          .thenAnswer((_) async => http.Response('', 204));

      await userRepository.deleteUser(userId);
      // Ensure that the toast is shown (You might need to mock Fluttertoast for this)
    });

    test('getUsers - Failure', () async {
      when(mockClient.get(Uri.parse('${BaseUrl}users?page=1&per_page=6')))
          .thenAnswer((_) async => http.Response('Failed to load users', 404));

      expect(() => userRepository.getUsers(1), throwsException);
    });
  });
}
