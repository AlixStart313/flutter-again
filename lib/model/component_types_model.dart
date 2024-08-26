
class Component_types{
  final int id;
  final String name;

  Component_types({
    required this.id,
    required this.name,
  });

  factory Component_types.fromJson(Map<String, dynamic> json) {
    return Component_types(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Component_types{id: $id, name: $name}';
  }

}