import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future addUserDetails(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("devices")
        .doc()
        .set(userInfoMap);
  }
}
