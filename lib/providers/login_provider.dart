import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

Future<String> login(String email, String password) async {
  // print(email);
  // print(password);
  final response = await post(
    Uri.parse('https://api.training.theburo.nl/auth/login'),
    body: {'email': email, 'password': password},
  );

  if (response.statusCode == 200) {
    String accessToken =
        jsonDecode(response.body)['data']['access_token'] ?? '';
    return accessToken;
  } else {
    // print(response.body);
    throw Exception('Failed to login');
  }
}
