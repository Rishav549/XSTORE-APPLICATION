part of 'list_data_bloc.dart';

abstract class ListDataEvents {}

class InitialListDataEvent extends ListDataEvents {}

class NextListDataEvent extends ListDataEvents{}

class NewEntryAddEvent extends ListDataEvents{
  final QrData data;

  NewEntryAddEvent({required this.data});
}