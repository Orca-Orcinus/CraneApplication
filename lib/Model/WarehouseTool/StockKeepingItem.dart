import 'package:craneapplication/Model/StockManagementModel/StockKeepingModel.dart';
import 'package:craneapplication/features/auth/firebasestore.dart';

class StockKeepingItem
{
  final FireStoreService _fireStoreService = FireStoreService();
  static const String collectionName = "warehouse_keeping";

  Future<void> updateStockTransfer(StockKeepingModel stockKeeping) async{
    try{
      String? docId = await _fireStoreService.getDocumentId(collection: collectionName, primaryKeyField: "itemCode", documentCode: stockKeeping.itemCode);

      await _fireStoreService.updateData(
        collection: collectionName,
        documentId: docId!,
        data: stockKeeping.toJson(),
      );
    }
    catch(e)
    {
      print('Error updating stock transfer: $e');
      rethrow;
    }
  }

  Future<void> addStockTransfer(StockKeepingModel stockKeeping) async{
    try{
      await _fireStoreService.addData(collection: collectionName, data: stockKeeping.toJson());
    }
    catch(e)
    {
      print('Error adding stock transfer: $e');
      rethrow;
    }
  }

  Future<void> deleteStockTransfer(StockKeepingModel stockKeeping) async{
    try{
      String? docId = await _fireStoreService.getDocumentId(collection: collectionName, primaryKeyField: "itemCode", documentCode: stockKeeping.itemCode);
       
      await _fireStoreService.deleteData(collection: collectionName, documentId: docId!);
    }
    catch(e)
    {
      print('Error deleting stock transfer: $e');
      rethrow;
    }
  }

  Future<List<StockKeepingModel>> fetchAllWarehouseItem() async{
    try{
      final snapshot = await _fireStoreService.streamCollection(collectionName)?.first;
      if(snapshot != null)
      {
        List<StockKeepingModel> warehouseItems = (snapshot['docs'] as List)
            .map((doc) => StockKeepingModel.fromJson(doc))
            .toList();
        return warehouseItems;
      }
      return [];
    }
    catch(e)
    {
      print('Error fetching warehouse items: $e');
      rethrow;
    }
  }

  Stream<List<StockKeepingModel>>? streamWarehouseItems() {
    return _fireStoreService.streamCollection(collectionName)?.map((snapshot) {
      List<StockKeepingModel> warehouseItems = (snapshot['docs'] as List)
          .map((doc) => StockKeepingModel.fromJson(doc))
          .toList();
      return warehouseItems;
    });
  }

  Future<List<String>> fetchWarehouseItemByName() async{
    try {
      final snapshot = await _fireStoreService.streamCollection(collectionName)?.first;
      if(snapshot != null)
      {
        List<String> warehouseItems = (snapshot['docs'] as List)
            .map((doc) => doc['itemDescription'] as String)
            .toList();
        return warehouseItems;
      }
      return [];

    } catch (e) {
      print('Error fetching warehouse items: $e');
      rethrow;
    }
  }
}