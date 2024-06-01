import 'package:flutter_application_1/storage_classes/auteur.dart';
import 'package:flutter_application_1/storage_classes/genre.dart';

class Boek {
  final String name;
  final Auteur author;
  final int id;
  final List<Genre> genres;
  final DateTime createdAt;
  final DateTime updatedAt;

  Boek({
    required this.name,
    required this.author,
    required this.id,
    required this.genres,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Boek.fromJson(Map<String, dynamic> json) {
    return Boek(
      name: json['name'],
      author: json['author'] != null
          ? Auteur.fromJson(json['author'])
          : Auteur(
              id: 0,
              name: 'Unknown',
              age: 0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
      id: json['id'],
      genres: List<Genre>.from(
          json['genres'].map((genre) => Genre.fromJson(genre))),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
