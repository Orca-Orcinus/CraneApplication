import 'package:craneapplication/Model/StockManagementModel/StockItemModel.dart';
import 'package:craneapplication/features/auth/firebasestore.dart';

class StockItemController{
  final FireStoreService _firestore = FireStoreService();

  static const String stockCollection = "stock_items";

  Future<void> updateStockItem(StockItemModel stockItem) async
  {
    try {

      String? docId = await _firestore.getDocumentId(collection: stockCollection, primaryKeyField: "itemCode", documentCode: stockItem.itemCode);
      
      if (docId != null)
      {
        await _firestore.updateData(collection: stockCollection, documentId: docId, data: stockItem.toJson());
      }
      else
      {
        print('Document ID not found for itemCode: ${stockItem.itemCode}');
      }
    } catch (e) {
      print('Error updating stock item: $e');
    rethrow;
    }
  }

  

  Future<void> createStockItem(StockItemModel stockItem) async
  {
    try {
      await _firestore.addData(collection: stockCollection, data: stockItem.toJson());
    } catch (e) {
      print('Error creating stock item: $e');
      rethrow;
    }
  }

  Future<void> deleteStockItem(StockItemModel stockItem) async
  {
    try{
      String? docId = await _firestore.getDocumentId(collection: stockCollection, primaryKeyField: "itemCode", documentCode: stockItem.itemCode);

      await _firestore.deleteData(collection: stockCollection, documentId: docId!);
    } 
    catch(e)
    {
      print('Error deleting stock item: $e');
      rethrow;
    }
  }

  Future<List<StockItemModel>> fetchAllStockItems() async
  {
    try{
      final snapshot = await _firestore.streamCollection(stockCollection)?.first;
      if(snapshot != null)
      {
        List<StockItemModel> stockItems = (snapshot['docs'] as List)
            .map((doc) => StockItemModel.fromJson(doc))
            .toList();
        return stockItems;
      }
      return [];
    }
    catch(e)
    {
      print('Error fetching stock items: $e');
      rethrow;
    }
  } 

  Stream<List<StockItemModel>> fetchAllStockItemsStream() {
    return _firestore.streamCollection(stockCollection)!.map((snapshot) {
      List<StockItemModel> stockItems = (snapshot['docs'] as List)
          .map((doc) => StockItemModel.fromJson(doc))
          .toList();
      return stockItems;
    });
  }

  Future<List<StockItemModel>> filterByStockItemGroup(String itemGroup) async
  {
    try{
      final snapshot = await _firestore.getDataBy(collection: stockCollection, contextName: "itemGroup", contextValue: itemGroup);
      if(snapshot != null)
      {
        List<StockItemModel> stockItems = (snapshot['docs'] as List)
            .map((doc) => StockItemModel.fromJson(doc))
            .toList();
        return stockItems;
      }
      return [];
    }
    catch(e)
    {
      print('Error filtering stock items by group: $e');
      rethrow;
    }
  }
}