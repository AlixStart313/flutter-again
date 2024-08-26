import 'package:equatable/equatable.dart';
import 'package:prueba1/model/component_types_model.dart';


abstract class DataState extends Equatable {
  const DataState();
  @override
  List<Object> get props => [];
}

class DataInitia extends DataState{}

class DataLoading extends DataState{}

class DataSuccess extends DataState{
  final List<dynamic> types;
  final List<dynamic> manufacturers;
  final List<dynamic> componentes;
  final List<dynamic> computers;
  const DataSuccess({required this.types, required this.manufacturers,required this.componentes,required this.computers});
   
  @override
  List<Object> get props =>[types];
}


class DataError extends DataState{
  final String message;
  const DataError({required this.message});
   
  @override
  List<Object> get props =>[message];
}

