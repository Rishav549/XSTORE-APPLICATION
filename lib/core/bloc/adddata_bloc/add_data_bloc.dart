library add_data_bloc;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xstore/core/models/qrdatamodel.dart';
import '../../models/errormodel.dart';
import '../../repository/adddata.dart';

part 'add_data_state.dart';

part 'add_data_events.dart';

class AddDataBloc extends Bloc<AddDataEvents, AddDataState> {
  final Database database;

  AddDataBloc(this.database) : super(AddDataInitialState()) {
    on<AddDataToFirebaseEvent>(_uploadData);
  }

  Future<void> _uploadData(
      AddDataToFirebaseEvent event, Emitter<AddDataState> emit) async {
    emit(AddDataLoadingState());
    try {
      await database.addUserDetails(event.data.toJson());
      emit(AddDataSuccessState(qrData: event.data));
    } catch (e) {
      emit(AddDataErrorState(
          error: ErrorModel(message: "DATA NOT ADDED TO DATABASE", e: e)));
    }
  }
}
