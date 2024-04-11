import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:task_mais/Repositery/LoginRepositery.dart';
import 'package:task_mais/consts/BaseUrl.dart';


class MockClient extends Mock implements http.Client {}

void main() {
  group('AuthRepository', () {
    final mockClient = MockClient();
    final authRepository = AuthRepository();

    test('login - Success', () async {
      final email = 'test@example.com';
      final password = 'password';

      final responseData = {'token': 'dummy_token'};
      when(mockClient.post(
        Uri.parse('${BaseUrl}login'),
        body: {'email': email, 'password': password},
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      final success = await authRepository.login(email, password);

      expect(success, true);
      verify(mockClient.post(Uri.parse('${BaseUrl}login'), body: {'email': email, 'password': password}));
    });

    test('login - Failure', () async {
      final email = 'test@example.com';
      final password = 'wrong_password';

      final responseData = {'error': 'Invalid credentials'};
      when(mockClient.post(
        Uri.parse('${BaseUrl}login'),
        body: {'email': email, 'password': password},
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 401));

      expect(() => authRepository.login(email, password), throwsException);
      verify(mockClient.post(Uri.parse('${BaseUrl}login'), body: {'email': email, 'password': password}));
    });
  });
}
