import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService
{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Create
  /// Adds [data] to [collection] and returns the created document id.
  Future<String> addData({required String collection, required Map<String,dynamic> data}) async {
    final ref = await _db.collection(collection).add(data);
    return ref.id;
  }

  //Read
  Future<List<Map<String,dynamic>>> getData({
    required String collection,
  }) async {
    QuerySnapshot snapshot = await _db.collection(collection).get();
    return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
        .toList();
  }

Future<Map<String, dynamic>?> getSpecificData({
  required String collection,
  required String id,
}) async {
  DocumentSnapshot doc = await _db.collection(collection).doc(id).get();

  if (doc.exists) {
    return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
  } else {
    return null; // Return null if the document does not exist
  }
}

  //Update
  Future<void> updateData({
    required String collection,
    required String documentId,
    required Map<String,dynamic> data,
  }) {
    return _db.collection(collection).doc(documentId).update(data);
  }

  //Delete
  Future<void> deleteData({
    required String collection,
    required String documentId,
  }) {
    return _db.collection(collection).doc(documentId).delete();
  }
}