import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Create a new product', () async {
    final url = Uri.parse('http://localhost:8080/api/products');
    final payload = {
      "productName": "test",
      "description": "sd",
      "image": "d",
    };

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload),
    );

    // Check if the response status code is 200 (OK)
    expect(response.statusCode, 200);

    // Parse the response body as JSON
    final responseBody = json.decode(response.body);

    // Perform assertions on the response body
    expect(responseBody, isMap);
    expect(responseBody['productName'], equals("test"));
    expect(responseBody['description'], equals("sd"));
    expect(responseBody['image'], equals("d"));
  });
}
