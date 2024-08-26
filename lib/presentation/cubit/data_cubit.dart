import 'package:bloc/bloc.dart';
import 'package:prueba1/model/component_types_model.dart';
import 'package:prueba1/model/manufacturer_model.dart';
import 'package:prueba1/presentation/data_state.dart';
import 'package:prueba1/repostory/data_repository.dart';

class DataCubit extends Cubit<DataState> {
  final DataRepository repository;
  DataCubit({required this.repository}): super(DataInitia());

  Future<void> getData() async{
    try {
      emit(DataLoading());
      final component_types = await repository.getComponent();
      final manufacturers = await repository.getManufacturers();
      final components  = await repository.getComponent();
      final commputers = await repository.getComputerSystem();
      emit(DataSuccess(types: component_types, manufacturers:manufacturers,componentes: components,computers: commputers));
    } catch (e) {
      emit(DataError(message: e.toString()));
    }
  }

}
