import 'package:craneapplication/Model/WarehouseTool/GroupItem.dart';
import 'package:craneapplication/Model/WarehouseTool/StockItem.dart';
import 'package:craneapplication/Model/WarehouseTool/StockReceivedItem.dart';
import 'package:craneapplication/Model/WarehouseTool/StockTransferItem.dart';

/// Database Controller for Warehouse Operations
/// Manages CRUD operations across multiple collections
class WarehouseDatabaseController {
  final StockItemController _stockItemController = StockItemController();
  final GroupItemController _groupItemController = GroupItemController();
  final StockTransferController _stockTransferController = StockTransferController();
  final StockReceivedItemController _stockReceivedItemController = StockReceivedItemController();  

  // /// Fetch warehouse items by supplier
  // Future<List<WarehouseModel>> getWarehousesBySupplier(String supplierName) async {
  //   try {
  //     final snapshot = await _firestore
  //         .collection(itemsCollection)
  //         .where('supplierName', isEqualTo: supplierName)
  //         .get();
  //     return snapshot.docs
  //         .map((doc) => WarehouseModel.fromJson(
  //             doc.data(),
  //             docId: doc.id))
  //         .toList();
  //   } catch (e) {
  //     throw Exception('Failed to fetch warehouse items by supplier: $e');
  //   }
  // }

  // /// Fetch warehouse items by category
  // Future<List<WarehouseModel>> getWarehousesByCategory(String category) async {
  //   try {
  //     final snapshot = await _firestore
  //         .collection(itemsCollection)
  //         .where('category', isEqualTo: category)
  //         .get();
  //     return snapshot.docs
  //         .map((doc) => WarehouseModel.fromJson(
  //             doc.data(),
  //             docId: doc.id))
  //         .toList();
  //   } catch (e) {
  //     throw Exception('Failed to fetch warehouse items by category: $e');
  //   }
  // }

  // /// Fetch warehouse items by order status
  // Future<List<WarehouseModel>> getWarehousesByOrderStatus(
  //     String orderStatus) async {
  //   try {
  //     final snapshot = await _firestore
  //         .collection(itemsCollection)
  //         .where('orderStatus', isEqualTo: orderStatus)
  //         .get();
  //     return snapshot.docs
  //         .map((doc) => WarehouseModel.fromJson(
  //             doc.data(),
  //             docId: doc.id))
  //         .toList();
  //   } catch (e) {
  //     throw Exception('Failed to fetch warehouse items by order status: $e');
  //   }
  // }

  // /// Fetch warehouse items by purchase order number
  // Future<List<WarehouseModel>> getWarehousesByPurchaseOrder(
  //     String purchaseOrderNumber) async {
  //   try {
  //     final snapshot = await _firestore
  //         .collection(itemsCollection)
  //         .where('purchaseOrderNumber', isEqualTo: purchaseOrderNumber)
  //         .get();
  //     return snapshot.docs
  //         .map((doc) => WarehouseModel.fromJson(
  //             doc.data(),
  //             docId: doc.id))
  //         .toList();
  //   } catch (e) {
  //     throw Exception('Failed to fetch warehouse items by purchase order: $e');
  //   }
  // }

  // /// Fetch warehouse items by delivery order number
  // Future<List<WarehouseModel>> getWarehousesByDeliveryOrder(
  //     String deliveryOrderNumber) async {
  //   try {
  //     final snapshot = await _firestore
  //         .collection(itemsCollection)
  //         .where('deliveryOrderNumber', isEqualTo: deliveryOrderNumber)
  //         .get();
  //     return snapshot.docs
  //         .map((doc) => WarehouseModel.fromJson(
  //             doc.data(),
  //             docId: doc.id))
  //         .toList();
  //   } catch (e) {
  //     throw Exception('Failed to fetch warehouse items by delivery order: $e');
  //   }
  // }

  // /// Fetch items with low stock
  // Future<List<WarehouseModel>> getLowStockItems() async {
  //   try {
  //     final snapshot = await _firestore
  //         .collection(itemsCollection)
  //         .get();
      
  //     final allItems = snapshot.docs
  //         .map((doc) => WarehouseModel.fromJson(
  //             doc.data(),
  //             docId: doc.id))
  //         .toList();

  //     // Filter items where quantity is less than or equal to minStockLevel
  //     return allItems
  //         .where((item) => item.quantity <= item.minStockLevel)
  //         .toList();
  //   } catch (e) {
  //     throw Exception('Failed to fetch low stock items: $e');
  //   }
  // }

  // /// Update warehouse quantity (inventory adjustment)
  // Future<void> updateQuantity(String warehouseId, int newQuantity) async {
  //   try {
  //     await _firestore.collection(itemsCollection).doc(warehouseId).update({
  //       'quantity': newQuantity,
  //       'updatedAt': FieldValue.serverTimestamp(),
  //     });
  //   } catch (e) {
  //     throw Exception('Failed to update quantity: $e');
  //   }
  // }

  // /// Update order status
  // Future<void> updateOrderStatus(
  //     String warehouseId, String newStatus) async {
  //   try {
  //     await _firestore.collection(itemsCollection).doc(warehouseId).update({
  //       'orderStatus': newStatus,
  //       'updatedAt': FieldValue.serverTimestamp(),
  //     });
  //   } catch (e) {
  //     throw Exception('Failed to update order status: $e');
  //   }
  // }

  // /// Update delivery status
  // Future<void> updateDeliveryStatus(
  //     String warehouseId, String newStatus) async {
  //   try {
  //     await _firestore.collection(itemsCollection).doc(warehouseId).update({
  //       'deliveryStatus': newStatus,
  //       'updatedAt': FieldValue.serverTimestamp(),
  //     });
  //   } catch (e) {
  //     throw Exception('Failed to update delivery status: $e');
  //   }
  // }

  // /// Update payment status
  // Future<void> updatePaymentStatus(
  //     String warehouseId, String newStatus) async {
  //   try {
  //     await _firestore.collection(itemsCollection).doc(warehouseId).update({
  //       'paymentStatus': newStatus,
  //       'updatedAt': FieldValue.serverTimestamp(),
  //     });
  //   } catch (e) {
  //     throw Exception('Failed to update payment status: $e');
  //   }
  // }

  // /// Record delivery
  // Future<void> recordDelivery(
  //     String warehouseId, DateTime deliveryDate) async {
  //   try {
  //     await _firestore.collection(itemsCollection).doc(warehouseId).update({
  //       'actualDeliveryDate': deliveryDate,
  //       'deliveryStatus': 'delivered',
  //       'updatedAt': FieldValue.serverTimestamp(),
  //     });
  //   } catch (e) {
  //     throw Exception('Failed to record delivery: $e');
  //   }
  // }

  // /// Delete warehouse item
  // Future<void> deleteWarehouse(String id) async {
  //   try {
  //     await _firestore.collection(itemsCollection).doc(id).delete();
  //   } catch (e) {
  //     throw Exception('Failed to delete warehouse item: $e');
  //   }
  // }

  // /// Get real-time updates for a warehouse item
  // Stream<WarehouseModel?> watchWarehouse(String id) {
  //   return _firestore
  //       .collection(itemsCollection)
  //       .doc(id)
  //       .snapshots()
  //       .map((doc) => doc.exists
  //           ? WarehouseModel.fromJson(
  //               doc.data() as Map<String, dynamic>,
  //               docId: doc.id)
  //           : null);
  // }

  // /// Get real-time updates for all warehouse items
  // Stream<List<WarehouseModel>> watchAllWarehouses() {
  //   return _firestore
  //       .collection(itemsCollection)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //           .map((doc) => WarehouseModel.fromJson(
  //               doc.data(),
  //               docId: doc.id))
  //           .toList());
  // }

  // /// Get real-time updates for items with pending orders
  // Stream<List<WarehouseModel>> watchPendingOrders() {
  //   return _firestore
  //       .collection(itemsCollection)
  //       .where('orderStatus', isEqualTo: 'pending')
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //           .map((doc) => WarehouseModel.fromJson(
  //               doc.data(),
  //               docId: doc.id))
  //           .toList());
  // }

  // /// Get inventory summary statistics
  // Future<Map<String, dynamic>> getInventorySummary() async {
  //   try {
  //     final snapshot = await _firestore.collection(itemsCollection).get();
  //     final items = snapshot.docs
  //         .map((doc) => WarehouseModel.fromJson(
  //             doc.data(),
  //             docId: doc.id))
  //         .toList();

  //     int totalItems = items.length;
  //     int totalQuantity = items.fold(0, (sum, item) => sum + item.quantity);
  //     double totalValue =
  //         items.fold(0.0, (sum, item) => sum + (item.unitCost * item.quantity));
  //     int lowStockCount =
  //         items.where((item) => item.quantity <= item.minStockLevel).length;
  //     int pendingOrdersCount =
  //         items.where((item) => item.orderStatus == 'pending').length;

  //     return {
  //       'totalItems': totalItems,
  //       'totalQuantity': totalQuantity,
  //       'totalValue': totalValue,
  //       'lowStockCount': lowStockCount,
  //       'pendingOrdersCount': pendingOrdersCount,
  //       'categories': _getCategories(items),
  //       'suppliers': _getSuppliers(items),
  //     };
  //   } catch (e) {
  //     throw Exception('Failed to get inventory summary: $e');
  //   }
  // }

  // /// Helper method to get unique categories
  // List<String> _getCategories(List<WarehouseModel> items) {
  //   return items
  //       .map((item) => item.category)
  //       .where((category) => category.isNotEmpty)
  //       .toSet()
  //       .toList();
  // }

  // /// Helper method to get unique suppliers
  // List<String> _getSuppliers(List<WarehouseModel> items) {
  //   return items
  //       .map((item) => item.supplierName)
  //       .where((supplier) => supplier.isNotEmpty)
  //       .toSet()
  //       .toList();
  // }

  // /// Batch update items
  // Future<void> batchUpdateWarehouse(List<WarehouseModel> items) async {
  //   try {
  //     WriteBatch batch = _firestore.batch();

  //     for (var item in items) {
  //       final docRef = _firestore.collection(itemsCollection).doc(item.id);
  //       batch.set(
  //           docRef,
  //           {
  //             ...item.toJson(),
  //             'updatedAt': FieldValue.serverTimestamp(),
  //           },
  //           SetOptions(merge: true));
  //     }

  //     await batch.commit();
  //   } catch (e) {
  //     throw Exception('Failed to batch update warehouse items: $e');
  //   }
  // }

  // /// Search warehouse items
  // Future<List<WarehouseModel>> searchWarehouses(String query) async {
  //   try {
  //     final snapshot = await _firestore.collection(itemsCollection).get();
  //     final allItems = snapshot.docs
  //         .map((doc) => WarehouseModel.fromJson(
  //             doc.data(),
  //             docId: doc.id))
  //         .toList();

  //     // Filter based on multiple fields
  //     final lowerQuery = query.toLowerCase();
  //     return allItems.where((item) {
  //       return item.itemName.toLowerCase().contains(lowerQuery) ||
  //           item.sku.toLowerCase().contains(lowerQuery) ||
  //           item.supplierName.toLowerCase().contains(lowerQuery) ||
  //           item.purchaseOrderNumber.toLowerCase().contains(lowerQuery) ||
  //           (item.deliveryOrderNumber?.toLowerCase().contains(lowerQuery) ?? false);
  //     }).toList();
  //   } catch (e) {
  //     throw Exception('Failed to search warehouse items: $e');
  //   }
  // }

  // /// Export inventory report
  // Future<String> generateInventoryReport() async {
  //   try {
  //     final summary = await getInventorySummary();
  //     final items = await getAllWarehouses();
  //     final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  //     StringBuffer report = StringBuffer();
  //     report.writeln('=== INVENTORY REPORT ===');
  //     report.writeln('Generated: ${dateFormat.format(DateTime.now())}');
  //     report.writeln('');
  //     report.writeln('SUMMARY:');
  //     report.writeln('Total Items: ${summary['totalItems']}');
  //     report.writeln('Total Quantity: ${summary['totalQuantity']}');
  //     report.writeln('Total Value: \$${summary['totalValue'].toStringAsFixed(2)}');
  //     report.writeln('Low Stock Items: ${summary['lowStockCount']}');
  //     report.writeln('Pending Orders: ${summary['pendingOrdersCount']}');
  //     report.writeln('');
  //     report.writeln('DETAILED INVENTORY:');
  //     report.writeln('-' * 100);

  //     for (var item in items) {
  //       report.writeln('Item: ${item.itemName}');
  //       report.writeln('  SKU: ${item.sku}');
  //       report.writeln('  Quantity: ${item.quantity}');
  //       report.writeln('  Supplier: ${item.supplierName}');
  //       report.writeln('  PO #: ${item.purchaseOrderNumber}');
  //       report.writeln('  DO #: ${item.deliveryOrderNumber ?? 'N/A'}');
  //       report.writeln('  Status: ${item.orderStatus} / ${item.deliveryStatus}');
  //       report.writeln('');
  //     }

  //     return report.toString();
  //   } catch (e) {
  //     throw Exception('Failed to generate inventory report: $e');
  //   }
//  }
}
