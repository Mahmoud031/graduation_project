import 'package:cloud_firestore/cloud_firestore.dart';

import 'database_service.dart';

class FirestoreService implements DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? documentId}) async {
    if (documentId != null) {
      await firestore.collection(path).doc(documentId).set(data);
    } else {
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future<dynamic> getData({required String path, String? documentId}) async {
    if (documentId != null) {
      var data = await firestore.collection(path).doc(documentId).get();
      return data.data();
    } else {
      var data = await firestore.collection(path).get();
      return data.docs.map((e) {
        var docData = e.data();
        docData['documentId'] = e.id;
        return docData;
      }).toList();
    }
  }

  @override
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  }) async {
    await firestore.collection(path).doc(documentId).update(data);
  }
  
  @override
  Future<void> deleteData({required String path, String? documentId}) {
    if (documentId != null) {
      return firestore.collection(path).doc(documentId).delete();
    } else {
      throw Exception('Document ID must be provided for deletion');
    }
  }
 
}
