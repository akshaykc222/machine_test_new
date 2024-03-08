import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final _fInstance = FirebaseFirestore.instance;

  // Create
  Future<void> addData(
      {required String collection, required Map<String, dynamic> data}) async {
    try {
      await _fInstance.collection(collection).add(data);
    } catch (e) {
      print(e);
    }
  }

  // Read
  Future<CollectionReference<Object?>> getData(
      {required String collection}) async {
    return _fInstance.collection(collection);
  }

  // Update
  Future<void> updateData(String docId, Map<String, dynamic> data) async {
    try {
      await _fInstance.doc(docId).update(data);
    } catch (e) {
      print(e);
    }
  }

  // Delete
  Future<void> deleteData(String docId) async {
    try {
      await _fInstance.doc(docId).delete();
    } catch (e) {
      print(e);
    }
  }
}
