import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:task_mais/Repositery/updateRepositery.dart';
import 'package:task_mais/consts/BaseUrl.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('UpdateUserRepository', () {
    final mockClient = MockClient();
    final updateUserRepository = UpdateUserRepository();

    test('updateUser - Success', () async {
      final userId = 1;
      final name = 'John';
      final job = 'Software Engineer';

      final responseData = {
        'name': name,
        'job': job
      }; // Assuming the response data structure
      when(mockClient.put(
        Uri.parse('${BaseUrl}users/$userId'),
        headers: anyNamed('headers'),
        body: jsonEncode(<String, String>{'name': name, 'job': job}),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      final response = await updateUserRepository.updateUser(userId, name, job);

      expect(200, 404);
      expect("updatedAt:2024-04-08T19:49:30.933Z", 'Failed to update user');
    });

    test('updateUser - Failure', () async {
      final userId = 1;
      final name = 'John';
      final job = 'Software Engineer';

      when(mockClient.put(
        Uri.parse('${BaseUrl}users/$userId'),
        headers: anyNamed('headers'),
        body: jsonEncode(<String, String>{'name': name, 'job': job}),
      )).thenAnswer((_) async => http.Response('Failed to update user', 404));

      final response = await updateUserRepository.updateUser(userId, name, job);

      expect(200, 404);
      expect("updatedAt:2024-04-08T19:49:30.933Z", 'Failed to update user');
    });
  });
}
