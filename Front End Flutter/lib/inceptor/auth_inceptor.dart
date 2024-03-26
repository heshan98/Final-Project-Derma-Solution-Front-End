
import 'package:project/services/TokenStorageService.dart';
import 'package:http/http.dart' as http;

class AuthInterceptor {
  final TokenStorageService tokenStorageService;

  AuthInterceptor(this.tokenStorageService);

  Future<http.Response> interceptRequest(http.Request request) async {
    final authToken = await tokenStorageService.getToken();
    if (authToken != null) {
      request.headers['x-access-token'] = authToken;
    }

    final response = await http.Client().send(request);
    return http.Response.fromStream(response);
  }
}
