import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/providers/secure_storage.dart';
import 'package:http/http.dart';

class LoginManager with ChangeNotifier {
  bool _isLoggedIn = false;

  LoginManager() {
    checkIfUserIsLoggedIn();
  }

  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkIfUserIsLoggedIn() async {
    var jwt = await SecureStorage().read('jwt');
    _isLoggedIn = jwt != null;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    try {
      var jwt = await _authenticate(email, password);
      await SecureStorage().write('jwt', jwt);
      _isLoggedIn = true;
      notifyListeners();
      print(' _isLoggedIn: $_isLoggedIn');
      return isLoggedIn;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    await SecureStorage().delete('jwt');
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<String> _authenticate(String email, String password) async {
    final response = await post(
      Uri.parse('https://api.training.theburo.nl/auth/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      String accessToken =
          jsonDecode(response.body)['data']['access_token'] ?? '';
      return accessToken;
    } else {
      throw Exception('Failed to login');
    }
  }
}
