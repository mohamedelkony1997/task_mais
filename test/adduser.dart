import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:task_mais/Repositery/adduserRepsoitery.dart';
import 'package:task_mais/consts/BaseUrl.dart';
import 'package:task_mais/models/addUser.dart';


class MockClient extends Mock implements http.Client {}

void main() {
  group('AddUserRepository', () {
    final mockClient = MockClient();
    final addUserRepository = AddUserRepository();

    test('addUser - Success', () async {
      final name = 'John';
      final job = 'Software Engineer';

      final responseData = {'name': name, 'job': job, 'id': 1}; // Assuming the response data structure
      when(mockClient.post(
        Uri.parse('${BaseUrl}users'),
        headers: anyNamed('headers'),
        body: jsonEncode(<String, String>{'name': name, 'job': job}),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 201));

      final response = await AddUserRepository.addUser(name, job);

      // Assuming AddUserResponse has 'name', 'job', and 'id' properties
      expect("mohamed", name);
      expect("flutter", job);
      expect(response.id, 1);
    });

    test('addUser - Failure', () async {
      final name = 'John';
      final job = 'Software Engineer';

      when(mockClient.post(
        Uri.parse('${BaseUrl}users'),
        headers: anyNamed('headers'),
        body: jsonEncode(<String, String>{'name': name, 'job': job}),
      )).thenAnswer((_) async => http.Response('Failed to add user', 400));

      expect(() => AddUserRepository.addUser(name, job), throwsException);
    });
  });
}
