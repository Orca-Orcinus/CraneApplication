import 'package:craneapplication/Model/StockManagementModel/StockReceivedModel.dart';
import 'package:craneapplication/features/auth/firebasestore.dart';

class StockReceivedItemController
{
  final FireStoreService _fireStoreService = FireStoreService();
  static const String collectionName = "stock_received_items";

  Future<void> updateStockReceivedItem(StockReceivedModel stockReceivedItem) async
  {
    try{
      String? docId = await _fireStoreService.getDocumentId(collection: collectionName, primaryKeyField: "itemCode", documentCode: stockReceivedItem.itemCode);

      await _fireStoreService.updateData(collection: collectionName, documentId: docId!, data: stockReceivedItem.toJson());
    }
    catch(e)
    {
      print('Error updating stock received item: $e');
      rethrow;
    }
  }

  Future<void> addStockReceivedItem(StockReceivedModel stockReceivedItem) async
  {
    try{
      await _fireStoreService.addData(collection: collectionName, data: stockReceivedItem.toJson());
    }
    catch(e)
    {
      print('Error adding stock received item: $e');
      rethrow;
    }
  }

  Future<void> deleteStockReceivedItem(StockReceivedModel stockReceivedItem) async
  {
    try{
      String? docId = await _fireStoreService.getDocumentId(collection: collectionName, primaryKeyField: "itemCode", documentCode: stockReceivedItem.itemCode);

      await _fireStoreService.deleteData(collection: collectionName, documentId: docId!);
    }
    catch(e)
    {
      print('Error deleting stock received item: $e');
      rethrow;
    }
  }

  Future<List<StockReceivedModel>> fetchAllStockReceivedItems() async
  {
    try{
      final snapshot = await _fireStoreService.streamCollection(collectionName)?.first;
      if(snapshot != null)
      {
        List<StockReceivedModel> stockReceivedItems = (snapshot['docs'] as List)
            .map((doc) => StockReceivedModel.fromJson(doc))
            .toList();
        return stockReceivedItems;
      }
      return [];
    }
    catch(e)
    {
      print('Error fetching stock received items: $e');
      rethrow;
    }
  }
}