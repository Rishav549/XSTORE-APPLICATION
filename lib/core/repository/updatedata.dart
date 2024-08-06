import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UpdateData {
  Future<void> updateDevice(String id, String deviceType) async {
    try {
      await FirebaseFirestore.instance.collection('devices').doc(id).update({
        'devicetype': deviceType,
        'updatedat': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      });
      print("Device type updated successfully");
    } catch (e) {
      print("Error Fetching data:$e");
    }
  }
}
