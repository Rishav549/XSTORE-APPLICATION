part of 'list_data_bloc.dart';

abstract class ListDataStates {}

class ListInitialState extends ListDataStates {}

class ListLoadingState extends ListDataStates {}

class ListLoadedState extends ListDataStates {
  final List<QrData> dataList;

  ListLoadedState({required this.dataList});
}

class ListErrorState extends ListDataStates {
  final ErrorModel error;

  ListErrorState({required this.error});
}
