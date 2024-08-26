class ComputerSystem {
  final int id;
  final String name;
  final List<SystemComponent> components;

  ComputerSystem({
    required this.id,
    required this.name,
    required this.components,
  });

  factory ComputerSystem.fromJson(Map<String, dynamic> json) {
    var componentsFromJson = json['components'] as List;
    List<SystemComponent> componentsList = componentsFromJson.map((component) => SystemComponent.fromJson(component)).toList();

    return ComputerSystem(
      id: json['id'] as int,
      name: json['name'] as String,
      components: componentsList,
    );
  }
}

class SystemComponent {
  final int componentId;
  final int quantity;

  SystemComponent({
    required this.componentId,
    required this.quantity,
  });

  factory SystemComponent.fromJson(Map<String, dynamic> json) {
    return SystemComponent(
      componentId: json['component_id'] as int,
      quantity: json['quantity'] as int,
    );
  }
}

