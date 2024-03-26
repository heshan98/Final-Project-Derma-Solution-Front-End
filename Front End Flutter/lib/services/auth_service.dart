import 'dart:convert';
import 'package:http/http.dart' as http;

const AUTH_API = 'http://192.168.8.100:8080/api/auth/';

class AuthService {
  Future<Map<String, dynamic>> login(String username, String password) async {
   
    final response = await http.post(
      Uri.parse(AUTH_API + 'signin'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    print('${response}response');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception("hello");
      throw Exception('Login failed with status: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> register(
      String username,
      String email,
      String password,
      ) async {
    final response = await http.post(
      Uri.parse(AUTH_API + 'signup'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Registration failed with status: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> logout() async {
    final response = await http.post(
      Uri.parse(AUTH_API + 'signout'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Logout failed with status: ${response.statusCode}');
    }
  }

}
