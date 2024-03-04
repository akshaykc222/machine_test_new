import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final fInstance = FirebaseFirestore.instance;

  // Create
  Future<void> addData(
      {required String collection, required Map<String, dynamic> data}) async {
    try {
      await fInstance.collection(collection).add(data);
    } catch (e) {
      print(e);
    }
  }

  // Read
  Future<List<Map<String, dynamic>>?> getData(
      {required String collection}) async {
    try {
      QuerySnapshot querySnapshot =
          await fInstance.collection(collection).get();
      return querySnapshot.docs
          .map((doc) => {doc.id: doc.data()})
          .toList(); // Return List<Map<String, dynamic>>
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Update
  Future<void> updateData(String docId, Map<String, dynamic> data) async {
    try {
      await fInstance.doc(docId).update(data);
    } catch (e) {
      print(e);
    }
  }

  // Delete
  Future<void> deleteData(String docId) async {
    try {
      await fInstance.doc(docId).delete();
    } catch (e) {
      print(e);
    }
  }
}
