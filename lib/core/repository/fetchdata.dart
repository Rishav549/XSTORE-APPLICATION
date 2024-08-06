import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/qrdatamodel.dart';

class FetchData {
  DocumentSnapshot? lastDocument;
  Future<List<QrData>> getqrdetails() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('devices').limit(10).orderBy('createdat', descending: true).get();
      List<QrData> data = querySnapshot.docs.map((doc) {
        return QrData.fromFirestore(doc);
      }).toList();
      lastDocument = querySnapshot.docs.last;
      return data;
    } catch (e) {
      print("Error Fetching data:$e");
      return [];
    }
  }
  
  Future<List<QrData>> getMoreQrDetails() async{
    try{
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('devices').orderBy('createdat', descending: true).startAfterDocument(lastDocument!).limit(10).get();
      List<QrData> data = querySnapshot.docs.map((doc) {
        return QrData.fromFirestore(doc);
      }).toList();
      return data;
    }catch(e){
      print("Error Fetching data:$e");
      return [];
    }
  }
}
