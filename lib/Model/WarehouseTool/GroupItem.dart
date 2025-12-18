import 'package:craneapplication/Model/StockManagementModel/GroupItemModel.dart';
import 'package:craneapplication/features/auth/firebasestore.dart';

class GroupItemController{
  final FireStoreService _firestore = FireStoreService();

  static const String groupCollection = "group_items";

  Future<void> updateGroupItem(GroupItemModel groupItem) async
  {
    try {
      String? docId = await _firestore.getDocumentId(collection: groupCollection, primaryKeyField: "itemCode", documentCode: groupItem.itemCode);

      await _firestore.updateData(collection: groupCollection, documentId: docId!, data: groupItem.toJson());

    } catch (e) {
      print('Error updating group item: $e');
      rethrow;
    }
  }

  Future<void> createGroupItem(GroupItemModel groupItem) async
  {
    try {
      await _firestore.addData(collection: groupCollection, data: groupItem.toJson());
    } catch (e) {
      print('Error creating group item: $e');
      rethrow;
    }
  }

  Future<void> deleteGroupItem(GroupItemModel groupItem) async
  {
    try{
      String? docId = await _firestore.getDocumentId(collection: groupCollection, primaryKeyField: "itemCode", documentCode: groupItem.itemCode);

      await _firestore.deleteData(collection: groupCollection, documentId: docId!);
    } 
    catch(e)
    {
      print('Error deleting group item: $e');
      rethrow;
    }
  }

  Future<List<GroupItemModel>> fetchAllGroupItems() async
  {
    try{
      final snapshot = await _firestore.streamCollection(groupCollection)?.first;
      if(snapshot != null)
      {
        List<GroupItemModel> groupItems = (snapshot['docs'] as List)
            .map((doc) => GroupItemModel.fromJson(doc))
            .toList();
        return groupItems;
      }
      return [];
    }
    catch(e)
    {
      print('Error fetching group items: $e');
      rethrow;
    }
  }

  Future<List<String>> fetchAllGroupItemNames() async
  {
    try{
      final snapshot = await _firestore.streamCollection(groupCollection)?.first;
      if(snapshot != null)
      {
        List<String> groupItems = (snapshot['docs'] as List)
            .map((doc) => doc['itemDescription'] as String)
            .toList();
        return groupItems;
      }
      return [];
    }
    catch(e)
    {
      print('Error fetching group items: $e');
      rethrow;
    }
  }
}