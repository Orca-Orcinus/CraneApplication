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
    DateTime? since,
    String dateField = 'updatedAt',
  }) async {
    Query query = _db.collection(collection);
    if (since != null) {
      // Firestore stores native Timestamp values if we send DateTime objects when writing.
      query = query.where(dateField, isGreaterThan: Timestamp.fromDate(since));
    }
    QuerySnapshot snapshot = await query.get();
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

Future<Map<String,dynamic>?> getDataBy({
  required String collection,
  required String contextName,
  required String contextValue,
}) async
{
  try{
    final snapshot = await _db.collection(collection).where(contextName, isEqualTo: contextValue).get();
    if(snapshot.docs.isNotEmpty)
    {
      return snapshot.docs.first.data();
    }
    return null;
  }
  catch(e)
  {
    throw Exception("Error getting data by $contextName: $e");
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

  Stream<Map<String, dynamic>>? streamCollection(String collection) {
    return _db.collection(collection).snapshots().map((qs) {
      return {
        'docs': qs.docs
            .map((doc) => {'id': doc.id, ...doc.data()})
            .toList()
      };
    });
  }

  Future<String?> getDocumentId({
    required String collection,
    required String primaryKeyField,
    required String documentCode,
  }) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
        .collection(collection)
        .where(primaryKeyField, isEqualTo: documentCode) // Query by jobId
        .limit(1) // Limit to one result
        .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id; // Return document ID
      }
      return null; // Return null if no match is found
    } catch (e) {
      print('Error retrieving document ID: $e');
      rethrow;
    }
  }
}