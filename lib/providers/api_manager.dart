import 'dart:convert';

import 'package:flutter_application_1/storage_classes/author.dart';
import 'package:flutter_application_1/storage_classes/book.dart';
import 'package:flutter_application_1/storage_classes/genre.dart';
import 'package:http/http.dart';

class ApiManager {
  static Future<List<Book>> fetchBooks() async {
    final response =
        await get(Uri.parse('https://api.training.theburo.nl/books/'));
    final List<dynamic> responseJson = json.decode(response.body)['data'];
    return List<Book>.from(responseJson.map((boek) => Book.fromJson(boek)));
  }

  static Future<Book> fetchBook(String id) async {
    return Book.fromJson(await getFromRoute('books', id));
  }

  static Future<List<Author>> fetchAuthors() async {
    final response =
        await get(Uri.parse('https://api.training.theburo.nl/authors/'));
    final List<dynamic> responseJson = json.decode(response.body)['data'];
    return List<Author>.from(
        responseJson.map((auteur) => Author.fromJson(auteur)));
  }

  static Future<List<Genre>> fetchGenres() async {
    final response =
        await get(Uri.parse('https://api.training.theburo.nl/genres/'));
    final List<dynamic> responseJson = json.decode(response.body)['data'];
    return List<Genre>.from(responseJson.map((genre) => Genre.fromJson(genre)));
  }

  static Future<Map<String, dynamic>> getFromRoute(
      String route, String id) async {
    final response =
        await get(Uri.parse('https://api.training.theburo.nl/$route/$id'));
    final Map<String, dynamic> responseJson =
        json.decode(response.body)['data'];
    return responseJson;
  }
}
