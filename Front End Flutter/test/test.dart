import 'package:test/test.dart';
import 'package:project/services/auth_service.dart';

// void main() {
//   group('AuthService', () {
//     test('login - Successful login', () async {
//       final authService = AuthService();
//       final username = 'test';
//       final password = '12345678';
//
//       final response = await authService.login(username, password);
//
//       expect(response, isA<Map<String, dynamic>>());
//
//     });
//
//     test('login - Failed login', () async {
//       final authService = AuthService();
//       final username = 'invalidUser';
//       final password = 'invalidPassword';
//
//       try {
//         final response = await authService.login(username, password);
//
//       } catch (e) {
//
//       }
//     });
//   });
// }
void main() {
  group('Registration API', () {
    test('Registration success', () async {
      final username = 'testuser1231';
      final email = 'testuse341@example.com';
      final password = '12345678';
      final authService = AuthService();
      final result = await authService.register(username, email, password);


      expect(result['message'], 'User was registered successfully!');
    });

    test('Registration failure', () async {
      final username = '';
      final email = 'testuser@example.com';
      final password = 'testpassword';
      final authService = AuthService();
      try {
        await authService.register(username, email, password);
        fail('Exception expected');
      } catch (e) {
        expect(e, isA<Exception>());
        expect(e.toString(), 'Exception: Registration failed with status: 400');
      }
    });
  });
}
