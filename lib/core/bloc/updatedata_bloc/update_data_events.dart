part of 'update_data_bloc.dart';

abstract class UpdateDataEvents {}

class UpdateDeviceTypeEvent extends UpdateDataEvents {
  final String id;
  final String deviceType;

  UpdateDeviceTypeEvent({required this.id, required this.deviceType});
}
