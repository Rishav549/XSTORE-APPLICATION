part of 'add_data_bloc.dart';

abstract class AddDataState {}

class AddDataInitialState extends AddDataState {}

class AddDataLoadingState extends AddDataState {}

class AddDataSuccessState extends AddDataState {
  final QrData qrData;
  AddDataSuccessState({required this.qrData});
}

class AddDataErrorState extends AddDataState {
  final ErrorModel error;

  AddDataErrorState({required this.error});
}
