
import 'dart:convert';
import 'package:prueba1/model/Component_model.dart';
import 'package:prueba1/model/component_types_model.dart';
import 'package:http/http.dart' as http;
import 'package:prueba1/model/computer_system.dart';
import 'package:prueba1/model/manufacturer_model.dart';

class DataRepository {
  final String url ="https://noeaywzny9.execute-api.us-east-1.amazonaws.com/Stage/hello";
  List<ComputerSystem>? computerSystem;

  DataRepository();

  Future <List<Component_types>> getComponentTypes() async{
    try {
        final response = await http.get(Uri.parse(url));
        if(response.statusCode == 200){
          List<dynamic> types = jsonDecode(response.body)['component_types'] ;
          List<Component_types> listTypes =  types.map((type)=> Component_types.fromJson(type  as Map<String,dynamic>)).toList();
          print(types);
          return listTypes;
        }
        throw Exception('Failed to fetch');
    } catch (e) {
      print(e);
        throw Exception('s${e.toString()}');
    }
  }

  Future <List<Manufacturer>> getManufacturers() async{
    try {
        final response = await http.get(Uri.parse(url));
        if(response.statusCode == 200){
          List<dynamic> manufacturersList = jsonDecode(response.body)['manufacturers'] ;
          List<Manufacturer> manufacturers =  manufacturersList.map((type)=> Manufacturer.fromJson(type  as Map<String,dynamic>)).toList();
          print(manufacturers);
          return manufacturers;
        }
        throw Exception('Failed to fetch');
    } catch (e) {
      print(e);
        throw Exception('Error al recuperar los componentes');
    }
  }

  Future <List<Component>> getComponent() async{
    try {
        final response = await http.get(Uri.parse(url));
        if(response.statusCode == 200){
          List<dynamic> componentsList = jsonDecode(response.body)['components'] ;
          List<Component> componentes =  componentsList.map((type)=> Component.fromJson(type  as Map<String,dynamic>)).toList();
          return componentes;
        }
        throw Exception('Failed to fetch');
    } catch (e) {
      print(e);
        throw Exception('Error al recuperar los componentes');
    }
  }

  Future <List<ComputerSystem>> getComputerSystem() async{
    try {
        final response = await http.get(Uri.parse(url));
        if(response.statusCode == 200){
          List<dynamic> computerSystemList = jsonDecode(response.body)['computer_systems'] ;
          computerSystem =computerSystemList.map((type)=> ComputerSystem.fromJson(type  as Map<String,dynamic>)).toList();
          return computerSystem!;
        }
        throw Exception('Failed to fetch');
    } catch (e) {
      print(e);
        throw Exception('Error al recuperar los componentes');
    }
  }
}