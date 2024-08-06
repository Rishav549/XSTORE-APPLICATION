library list_data_bloc;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xstore/core/models/errormodel.dart';
import 'package:xstore/core/repository/fetchdata.dart';

import '../../models/qrdatamodel.dart';

part 'list_data_states.dart';
part 'list_data_events.dart';

class ListDataBloc extends Bloc<ListDataEvents, ListDataStates>{
  final FetchData fetchData;
  List<QrData> dataList = [];
  bool isLoadingMoreData=true;
  ListDataBloc({required this.fetchData}): super(ListInitialState()){
    on<InitialListDataEvent>(_fetchData);
    on<NextListDataEvent>(_nextData);
    on<NewEntryAddEvent>(_newEntry);
  }

  Future<void> _fetchData( InitialListDataEvent event , Emitter<ListDataStates> emit)async{
  try{
    emit(ListLoadingState());
    List<QrData> data = await fetchData.getqrdetails();
    dataList.addAll(data);
    emit(ListLoadedState(dataList: data));
  }catch(e){
    emit(
          ListErrorState(error: ErrorModel(message: "Data Not fetched", e: e)));
    }
  }
  Future<void> _nextData(NextListDataEvent event , Emitter<ListDataStates> emit)async {
    try {
      if (isLoadingMoreData) {
        emit(ListLoadingState());
        List<QrData> data = await fetchData.getMoreQrDetails();
        if(data.length <= 10){
          isLoadingMoreData=false;
          dataList.addAll(data);
        }
        dataList.addAll(data);
        emit(ListLoadedState(dataList: dataList));
      }
    }
    catch(e){
      emit(
          ListErrorState(error: ErrorModel(message: "Data Not fetched", e: e)));
    }
  }
  Future<void> _newEntry( NewEntryAddEvent event, Emitter<ListDataStates> emit) async{
      emit(ListLoadingState());
      dataList.insert(0, event.data);
      emit(ListLoadedState(dataList: dataList));
  }
}