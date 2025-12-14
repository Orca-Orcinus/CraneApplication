import 'package:craneapplication/Model/StockManagementModel/StockTransferModel.dart';
import 'package:craneapplication/features/auth/firebasestore.dart';

class StockTransferController
{
  final FireStoreService _fireStoreService = FireStoreService();
  static const String collectionName = "stock_transfers";

  Future<void> updateStockTransfer(StockTransferModel stockTransfer) async{
    try{
      String? docId = await _fireStoreService.getDocumentId(collection: collectionName, primaryKeyField: "itemCode", documentCode: stockTransfer.itemCode);

      await _fireStoreService.updateData(
        collection: collectionName,
        documentId: docId!,
        data: stockTransfer.toJson(),
      );
    }
    catch(e)
    {
      print('Error updating stock transfer: $e');
      rethrow;
    }
  }

  Future<void> addStockTransfer(StockTransferModel stockTransfer) async{
    try{
      await _fireStoreService.addData(collection: collectionName, data: stockTransfer.toJson());
    }
    catch(e)
    {
      print('Error adding stock transfer: $e');
      rethrow;
    }
  }

  Future<void> deleteStockTransfer(StockTransferModel stockTransfer) async{
    try{
      String? docId = await _fireStoreService.getDocumentId(collection: collectionName, primaryKeyField: "itemCode", documentCode: stockTransfer.itemCode);
       
      await _fireStoreService.deleteData(collection: collectionName, documentId: docId!);
    }
    catch(e)
    {
      print('Error deleting stock transfer: $e');
      rethrow;
    }
  }

  Future<List<StockTransferModel>> fetchAllStockTransfers() async{
    try{
      final snapshot = await _fireStoreService.streamCollection(collectionName)?.first;
      if(snapshot != null)
      {
        List<StockTransferModel> stockTransfers = (snapshot['docs'] as List)
            .map((doc) => StockTransferModel.fromJson(doc))
            .toList();
        return stockTransfers;
      }
      return [];
    }
    catch(e)
    {
      print('Error fetching stock transfers: $e');
      rethrow;
    }
  }

  Stream<List<StockTransferModel>>? streamStockTransfers() {
    return _fireStoreService.streamCollection(collectionName)?.map((snapshot) {
      List<StockTransferModel> stockTransfers = (snapshot['docs'] as List)
          .map((doc) => StockTransferModel.fromJson(doc))
          .toList();
      return stockTransfers;
    });
  }
}