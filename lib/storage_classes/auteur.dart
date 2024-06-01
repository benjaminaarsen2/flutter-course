class Auteur {
  final int id;
  final String name;
  final int age;
  final DateTime createdAt;
  final DateTime updatedAt;

  Auteur({
    required this.id,
    required this.name,
    required this.age,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Auteur.fromJson(Map<String, dynamic> json) {
    return Auteur(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
