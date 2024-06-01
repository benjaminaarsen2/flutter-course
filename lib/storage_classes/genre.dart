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
}
