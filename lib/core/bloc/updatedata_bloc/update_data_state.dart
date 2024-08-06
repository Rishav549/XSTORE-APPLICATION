part of 'update_data_bloc.dart';

abstract class UpdateDataState {}

class UpdateInitialState extends UpdateDataState {}

class UpdateLoadingState extends UpdateDataState {}

class UpdateLoadedState extends UpdateDataState {}

class UpdateErrorState extends UpdateDataState {
  final ErrorModel error;

  UpdateErrorState({required this.error});
}
