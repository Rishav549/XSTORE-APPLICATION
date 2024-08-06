import 'package:cloud_firestore/cloud_firestore.dart';

class QrData {
  final String id;
  final String qrArray;
  final String deviceType;
  final String entryBy;
  final String isActive;
  final String? remarks;
  final String createdAt;
  final String updatedAt;

  QrData({
    required this.id,
    required this.qrArray,
    required this.deviceType,
    required this.entryBy,
    required this.isActive,
    required this.remarks,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QrData.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return QrData(
      id: doc.id,
      qrArray: doc['qrarray'],
      deviceType: doc['devicetype'],
      entryBy: doc['entryby'],
      isActive: doc['isactive'],
      createdAt: data['createdat'],
      updatedAt: data['updatedat'],
      remarks: data['remarks'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'qrarray': qrArray,
      'devicetype': deviceType,
      'entryby': entryBy,
      'isactive':isActive,
      'remarks': remarks,
      'createdat': createdAt,
      'updatedat': updatedAt,
    };
  }
}
