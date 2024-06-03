import 'dart:convert';

import 'package:flutter_application_1/storage_classes/auteur.dart';
import 'package:flutter_application_1/storage_classes/boek.dart';
import 'package:flutter_application_1/storage_classes/genre.dart';
import 'package:http/http.dart';

class ApiManager {
  static Future<List<Boek>> fetchBooks() async {
    final response =
        await get(Uri.parse('https://api.training.theburo.nl/books/'));
    final List<dynamic> responseJson = json.decode(response.body)['data'];
    return List<Boek>.from(responseJson.map((boek) => Boek.fromJson(boek)));
  }

  static Future<List<Auteur>> fetchAuthors() async {
    final response =
        await get(Uri.parse('https://api.training.theburo.nl/authors/'));
    final List<dynamic> responseJson = json.decode(response.body)['data'];
    return List<Auteur>.from(
        responseJson.map((auteur) => Auteur.fromJson(auteur)));
  }

  static Future<List<Genre>> fetchGenres() async {
    final response =
        await get(Uri.parse('https://api.training.theburo.nl/genres/'));
    final List<dynamic> responseJson = json.decode(response.body)['data'];
    return List<Genre>.from(responseJson.map((genre) => Genre.fromJson(genre)));
  }

  static Future<Boek> getFromRoute(String route, String id) async {
    final response =
        await get(Uri.parse('https://api.training.theburo.nl/$route/$id'));
    final Map<String, dynamic> responseJson =
        json.decode(response.body)['data'];
    return Boek.fromJson(responseJson);
  }
}
