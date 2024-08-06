part of 'add_data_bloc.dart';

abstract class AddDataEvents {}

class AddDataToFirebaseEvent extends AddDataEvents {
  final QrData data;

  AddDataToFirebaseEvent({required this.data});
}
