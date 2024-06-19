import 'package:flutter_application_1/storage_classes/author.dart';
import 'package:flutter_application_1/storage_classes/genre.dart';

class Book {
  final String name;
  final Author author;
  final int id;
  final List<Genre> genres;
  final DateTime createdAt;
  final DateTime updatedAt;

  Book({
    required this.name,
    required this.author,
    this.id = 0,
    required this.genres,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      name: json['name'],
      author: json['author'] != null
          ? Author.fromJson(json['author'])
          : Author(
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
