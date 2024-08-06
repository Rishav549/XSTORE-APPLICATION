library update_data_bloc;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xstore/core/models/errormodel.dart';

import '../../repository/updatedata.dart';

part 'update_data_events.dart';

part 'update_data_state.dart';

class UpdateDataBloc extends Bloc<UpdateDataEvents, UpdateDataState> {
  final UpdateData _updateDataServices;

  UpdateDataBloc(this._updateDataServices) : super(UpdateInitialState()) {
    on<UpdateDeviceTypeEvent>(_updateDevice);
  }

  Future<void> _updateDevice(
      UpdateDeviceTypeEvent event, Emitter<UpdateDataState> emit) async {
    try {
      emit(UpdateLoadingState());
      await _updateDataServices.updateDevice(event.id, event.deviceType);
      emit(UpdateLoadedState());
    } catch (e) {
      emit(UpdateErrorState(
          error: ErrorModel(message: "Data Not fetched", e: e)));
    }
  }
}
