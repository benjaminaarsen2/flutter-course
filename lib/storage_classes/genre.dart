import 'dart:convert';

class Genre {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  Genre({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Genre.fromString(String jsonString) {
    return Genre.fromJson(json.decode(jsonString));
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
