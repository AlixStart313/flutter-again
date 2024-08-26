

class Component {
  final int id;
  final String name;
  final int manufacturerId;
  final int componentTypeId;

  Component({
    required this.id,
    required this.name,
    required this.manufacturerId,
    required this.componentTypeId,
  });

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      id: json['id'] as int,
      name: json['name'] as String,
      manufacturerId: json['manufacturer_id'] as int,
      componentTypeId: json['component_type_id'] as int,
    );
  }
}
