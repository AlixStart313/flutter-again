class Manufacturer {
  final int id;
  final String name;
  final String country;

  Manufacturer({
    required this.id,
    required this.name,
    required this.country,
  });

  factory Manufacturer.fromJson(Map<String, dynamic> json) {
    return Manufacturer(
      id: json['id'] as int,
      name: json['name'] as String,
      country: json['country'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
    };
  }
}
