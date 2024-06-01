import 'dart:convert';

import 'package:flutter_application_1/storage_classes/boek.dart';
import 'package:http/http.dart';

class ApiManager {
  static Future<List<Boek>> fetchBooks() async {
    final response =
        await get(Uri.parse('https://api.training.theburo.nl/books/'));
    final List<dynamic> responseJson = json.decode(response.body)['data'];
    print(responseJson);
    return List<Boek>.from(responseJson.map((boek) => Boek.fromJson(boek)));
  }
}
