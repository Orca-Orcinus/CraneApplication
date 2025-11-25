import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import 'package:craneapplication/features/app_database.dart';

/// Warehouse Model Class for managing inventory, suppliers, purchase orders, and deliveries
/// This model supports operations across multiple database tables/collections
class WarehouseModel {
  // Primary identifiers
  final String id;
  final String itemId;
  final int? supplierRefId;

  // Item information
  final String itemName;
  final String itemDescription;
  final String category;
  final String sku;
  final double unitCost;

  // Supplier information
  final String supplierName;
  final String supplierContact;
  final String supplierEmail;
  final String supplierPhone;

  // Inventory tracking
  final int quantity;
  final int minStockLevel;
  final int maxStockLevel;
  final String unit;
  final String warehouseLocation;

  // Order information
  final String purchaseOrderNumber;
  final String? deliveryOrderNumber;
  final DateTime? purchaseOrderDate;
  final DateTime? expectedDeliveryDate;
  final DateTime? actualDeliveryDate;

  // Order status and tracking
  final String orderStatus; // pending, confirmed, shipped, delivered, cancelled
  final String deliveryStatus; // not_ordered, ordered, in_transit, delivered
  final double totalAmount;
  final String paymentStatus; // unpaid, partial, paid

  // Metadata
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String createdBy;
  final String? notes; 

  WarehouseModel({
    String? id,
    required this.itemId,
    this.supplierRefId,
    required this.itemName,
    this.itemDescription = '',
    this.category = '',
    this.sku = '',
    this.unitCost = 0.0,
    required this.supplierName,
    this.supplierContact = '',
    this.supplierEmail = '',
    this.supplierPhone = '',
    required this.quantity,
    this.minStockLevel = 0,
    this.maxStockLevel = 1000,
    this.unit = 'pcs',
    this.warehouseLocation = '',
    this.purchaseOrderNumber = '',
    this.deliveryOrderNumber,
    this.purchaseOrderDate,
    this.expectedDeliveryDate,
    this.actualDeliveryDate,
    this.orderStatus = 'pending',
    this.deliveryStatus = 'not_ordered',
    this.totalAmount = 0.0,
    this.paymentStatus = 'unpaid',
    this.createdAt,
    this.updatedAt,
    required this.createdBy,
    this.notes,
  }) : id = id ?? Uuid().v4();

  /// Convert Warehouse Model to JSON for database storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemId': itemId,
      'itemName': itemName,
      'itemDescription': itemDescription,
      'category': category,
      'sku': sku,
      'unitCost': unitCost,
      'supplierName': supplierName,
      'supplierContact': supplierContact,
      'supplierEmail': supplierEmail,
      'supplierPhone': supplierPhone,
      'quantity': quantity,
      'minStockLevel': minStockLevel,
      'maxStockLevel': maxStockLevel,
      'unit': unit,
      'warehouseLocation': warehouseLocation,
      'purchaseOrderNumber': purchaseOrderNumber,
      'deliveryOrderNumber': deliveryOrderNumber,
      // store DateTime directly so Firestore client serializes to Timestamp
      'purchaseOrderDate': purchaseOrderDate,
      'expectedDeliveryDate': expectedDeliveryDate,
      'actualDeliveryDate': actualDeliveryDate,
      'orderStatus': orderStatus,
      'deliveryStatus': deliveryStatus,
      'totalAmount': totalAmount,
      'paymentStatus': paymentStatus,
      // prefer leaving createdAt/updatedAt as DateTime (Firestore will accept DateTime or server timestamp)
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'createdBy': createdBy,
      'notes': notes,
      'supplierRefId': supplierRefId,
    };
  }

  /// Create Warehouse Model from JSON
  factory WarehouseModel.fromJson(Map<String, dynamic> json, {String? docId}) {
    return WarehouseModel(
      id: docId ?? json['id'],
      itemId: json['itemId'] ?? '',
      supplierRefId: json['supplierRefId'],
      itemName: json['itemName'] ?? '',
      itemDescription: json['itemDescription'] ?? '',
      category: json['category'] ?? '',
      sku: json['sku'] ?? '',
      unitCost: (json['unitCost'] ?? 0).toDouble(),
      supplierName: json['supplierName'] ?? '',
      supplierContact: json['supplierContact'] ?? '',
      supplierEmail: json['supplierEmail'] ?? '',
      supplierPhone: json['supplierPhone'] ?? '',
      quantity: json['quantity'] ?? 0,
      minStockLevel: json['minStockLevel'] ?? 0,
      maxStockLevel: json['maxStockLevel'] ?? 1000,
      unit: json['unit'] ?? 'pcs',
      warehouseLocation: json['warehouseLocation'] ?? '',
      purchaseOrderNumber: json['purchaseOrderNumber'] ?? '',
      deliveryOrderNumber: json['deliveryOrderNumber'],
        purchaseOrderDate: _parseDate(json['purchaseOrderDate']),
        expectedDeliveryDate: _parseDate(json['expectedDeliveryDate']),
        actualDeliveryDate: _parseDate(json['actualDeliveryDate']),
      orderStatus: json['orderStatus'] ?? 'pending',
      deliveryStatus: json['deliveryStatus'] ?? 'not_ordered',
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      paymentStatus: json['paymentStatus'] ?? 'unpaid',
      createdAt: _parseDate(json['createdAt']),
      updatedAt: _parseDate(json['updatedAt']),
      createdBy: json['createdBy'] ?? '',
      notes: json['notes'],
    );
  }

  /// Create a WarehouseModel from a DB row (generated data class `WarehouseItem`).
  factory WarehouseModel.fromDb(WarehouseItem row) {
    return WarehouseModel(
      id: row.itemId ?? row.id.toString(),
      itemId: row.itemId,
      itemName: row.itemName,
      itemDescription: row.itemDescription ?? '',
      category: row.category ?? '',
      sku: row.sku ?? '',
      unitCost: row.unitCost,
      supplierName: row.supplierName ?? '',
      supplierContact: row.supplierContact ?? '',
      supplierEmail: row.supplierEmail ?? '',
      supplierPhone: row.supplierPhone ?? '',
      supplierRefId: row.supplierRef,
      quantity: row.quantity,
      minStockLevel: row.minStockLevel,
      maxStockLevel: row.maxStockLevel,
      unit: row.unit ?? 'pcs',
      warehouseLocation: row.warehouseLocation ?? '',
      purchaseOrderNumber: row.purchaseOrderNumber ?? '',
      deliveryOrderNumber: row.deliveryOrderNumber,
      purchaseOrderDate: row.purchaseOrderDate,
      expectedDeliveryDate: row.expectedDeliveryDate,
      actualDeliveryDate: row.actualDeliveryDate,
      orderStatus: row.orderStatus,
      deliveryStatus: row.deliveryStatus,
      totalAmount: row.totalAmount,
      paymentStatus: row.paymentStatus,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      createdBy: row.createdBy ?? '',
      notes: row.notes,
    );
  }

  /// Helper to parse a dynamic value into DateTime.
  /// Supports Firestore `Timestamp`, `DateTime`, ISO `String`, and milliseconds `int`.
  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is Timestamp) return value.toDate();
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        // try parsing as int string
        final intVal = int.tryParse(value);
        if (intVal != null) return DateTime.fromMillisecondsSinceEpoch(intVal);
        return null;
      }
    }
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return null;
  }

  /// Create a copy with modified fields
  WarehouseModel copyWith({
    String? id,
    String? itemId,
    int? supplierRefId,
    String? itemName,
    String? itemDescription,
    String? category,
    String? sku,
    double? unitCost,
    String? supplierName,
    String? supplierContact,
    String? supplierEmail,
    String? supplierPhone,
    int? quantity,
    int? minStockLevel,
    int? maxStockLevel,
    String? unit,
    String? warehouseLocation,
    String? purchaseOrderNumber,
    String? deliveryOrderNumber,
    DateTime? purchaseOrderDate,
    DateTime? expectedDeliveryDate,
    DateTime? actualDeliveryDate,
    String? orderStatus,
    String? deliveryStatus,
    double? totalAmount,
    String? paymentStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    String? notes,
  }) {
    return WarehouseModel(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      supplierRefId: supplierRefId ?? this.supplierRefId,
      itemName: itemName ?? this.itemName,
      itemDescription: itemDescription ?? this.itemDescription,
      category: category ?? this.category,
      sku: sku ?? this.sku,
      unitCost: unitCost ?? this.unitCost,
      supplierName: supplierName ?? this.supplierName,
      supplierContact: supplierContact ?? this.supplierContact,
      supplierEmail: supplierEmail ?? this.supplierEmail,
      supplierPhone: supplierPhone ?? this.supplierPhone,
      quantity: quantity ?? this.quantity,
      minStockLevel: minStockLevel ?? this.minStockLevel,
      maxStockLevel: maxStockLevel ?? this.maxStockLevel,
      unit: unit ?? this.unit,
      warehouseLocation: warehouseLocation ?? this.warehouseLocation,
      purchaseOrderNumber: purchaseOrderNumber ?? this.purchaseOrderNumber,
      deliveryOrderNumber: deliveryOrderNumber ?? this.deliveryOrderNumber,
      purchaseOrderDate: purchaseOrderDate ?? this.purchaseOrderDate,
      expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
      actualDeliveryDate: actualDeliveryDate ?? this.actualDeliveryDate,
      orderStatus: orderStatus ?? this.orderStatus,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      notes: notes ?? this.notes,
    );
  }

  @override
  String toString() {
    return 'WarehouseModel(id: $id, itemName: $itemName, quantity: $quantity, orderStatus: $orderStatus)';
  }
}

extension WarehouseModelDb on WarehouseModel {
  /// Convert this WarehouseModel into a Drift companion for insertion/update.
  Insertable<WarehouseItem> toCompanion() {
    return WarehouseItemsCompanion(
      // id is autoincrement in DB - don't include it when saving from Firestore model
      itemId: Value(itemId),
      itemName: Value(itemName),
      itemDescription: itemDescription.isEmpty ? const Value.absent() : Value(itemDescription),
      category: category.isEmpty ? const Value.absent() : Value(category),
      sku: sku.isEmpty ? const Value.absent() : Value(sku),
      unitCost: Value(unitCost),
      supplierName: supplierName.isEmpty ? const Value.absent() : Value(supplierName),
      supplierContact: supplierContact.isEmpty ? const Value.absent() : Value(supplierContact),
      supplierEmail: supplierEmail.isEmpty ? const Value.absent() : Value(supplierEmail),
      supplierPhone: supplierPhone.isEmpty ? const Value.absent() : Value(supplierPhone),
      quantity: Value(quantity),
      minStockLevel: Value(minStockLevel),
      maxStockLevel: Value(maxStockLevel),
      unit: Value(unit),
      warehouseLocation: warehouseLocation.isEmpty ? const Value.absent() : Value(warehouseLocation),
      purchaseOrderNumber: purchaseOrderNumber.isEmpty ? const Value.absent() : Value(purchaseOrderNumber),
      deliveryOrderNumber: deliveryOrderNumber == null ? const Value.absent() : Value(deliveryOrderNumber!),
      purchaseOrderDate: purchaseOrderDate == null ? const Value.absent() : Value(purchaseOrderDate!),
      expectedDeliveryDate: expectedDeliveryDate == null ? const Value.absent() : Value(expectedDeliveryDate!),
      actualDeliveryDate: actualDeliveryDate == null ? const Value.absent() : Value(actualDeliveryDate!),
      orderStatus: Value(orderStatus),
      deliveryStatus: Value(deliveryStatus),
      totalAmount: Value(totalAmount),
      paymentStatus: Value(paymentStatus),
      createdAt: createdAt == null ? const Value.absent() : Value(createdAt!),
      updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt!),
      createdBy: createdBy.isEmpty ? const Value.absent() : Value(createdBy),
      notes: notes == null ? const Value.absent() : Value(notes!),
      supplierRef: supplierRefId == null ? const Value.absent() : Value(supplierRefId),
    );
  }
}

/// Database Controller for Warehouse Operations
/// Manages CRUD operations across multiple collections
class WarehouseDatabaseController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection names
  static const String itemsCollection = 'warehouse_items';
  static const String suppliersCollection = 'suppliers';
  static const String purchaseOrdersCollection = 'purchase_orders';
  static const String deliveryOrdersCollection = 'delivery_orders';
  static const String inventoryCollection = 'inventory';

  /// Create or update a warehouse item
  Future<String> saveWarehouse(WarehouseModel warehouse) async {
    try {
      final data = warehouse.toJson();
      final docRef =
          _firestore.collection(itemsCollection).doc(warehouse.id);

      await docRef.set({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return docRef.id;
    } catch (e) {
      throw Exception('Failed to save warehouse item: $e');
    }
  }

  /// Create a new warehouse item with auto-generated ID
  Future<String> createWarehouse(WarehouseModel warehouse) async {
    try {
      final data = warehouse.toJson();
      data['createdAt'] = FieldValue.serverTimestamp();
      data['updatedAt'] = FieldValue.serverTimestamp();

      final docRef = await _firestore.collection(itemsCollection).add(data);
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create warehouse item: $e');
    }
  }

  /// Fetch a single warehouse item by ID
  Future<WarehouseModel?> getWarehouse(String id) async {
    try {
      final doc = await _firestore.collection(itemsCollection).doc(id).get();
      if (doc.exists) {
        return WarehouseModel.fromJson(doc.data() as Map<String, dynamic>,
            docId: doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch warehouse item: $e');
    }
  }

  /// Fetch all warehouse items
  Future<List<WarehouseModel>> getAllWarehouses() async {
    try {
      final snapshot = await _firestore.collection(itemsCollection).get();      
      return snapshot.docs
          .map((doc) => WarehouseModel.fromJson(
              doc.data() as Map<String, dynamic>,
              docId: doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch warehouse items: $e');
    }
  }

  /// Fetch warehouse items by supplier
  Future<List<WarehouseModel>> getWarehousesBySupplier(String supplierName) async {
    try {
      final snapshot = await _firestore
          .collection(itemsCollection)
          .where('supplierName', isEqualTo: supplierName)
          .get();
      return snapshot.docs
          .map((doc) => WarehouseModel.fromJson(
              doc.data() as Map<String, dynamic>,
              docId: doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch warehouse items by supplier: $e');
    }
  }

  /// Fetch warehouse items by category
  Future<List<WarehouseModel>> getWarehousesByCategory(String category) async {
    try {
      final snapshot = await _firestore
          .collection(itemsCollection)
          .where('category', isEqualTo: category)
          .get();
      return snapshot.docs
          .map((doc) => WarehouseModel.fromJson(
              doc.data() as Map<String, dynamic>,
              docId: doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch warehouse items by category: $e');
    }
  }

  /// Fetch warehouse items by order status
  Future<List<WarehouseModel>> getWarehousesByOrderStatus(
      String orderStatus) async {
    try {
      final snapshot = await _firestore
          .collection(itemsCollection)
          .where('orderStatus', isEqualTo: orderStatus)
          .get();
      return snapshot.docs
          .map((doc) => WarehouseModel.fromJson(
              doc.data() as Map<String, dynamic>,
              docId: doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch warehouse items by order status: $e');
    }
  }

  /// Fetch warehouse items by purchase order number
  Future<List<WarehouseModel>> getWarehousesByPurchaseOrder(
      String purchaseOrderNumber) async {
    try {
      final snapshot = await _firestore
          .collection(itemsCollection)
          .where('purchaseOrderNumber', isEqualTo: purchaseOrderNumber)
          .get();
      return snapshot.docs
          .map((doc) => WarehouseModel.fromJson(
              doc.data() as Map<String, dynamic>,
              docId: doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch warehouse items by purchase order: $e');
    }
  }

  /// Fetch warehouse items by delivery order number
  Future<List<WarehouseModel>> getWarehousesByDeliveryOrder(
      String deliveryOrderNumber) async {
    try {
      final snapshot = await _firestore
          .collection(itemsCollection)
          .where('deliveryOrderNumber', isEqualTo: deliveryOrderNumber)
          .get();
      return snapshot.docs
          .map((doc) => WarehouseModel.fromJson(
              doc.data() as Map<String, dynamic>,
              docId: doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch warehouse items by delivery order: $e');
    }
  }

  /// Fetch items with low stock
  Future<List<WarehouseModel>> getLowStockItems() async {
    try {
      final snapshot = await _firestore
          .collection(itemsCollection)
          .get();
      
      final allItems = snapshot.docs
          .map((doc) => WarehouseModel.fromJson(
              doc.data() as Map<String, dynamic>,
              docId: doc.id))
          .toList();

      // Filter items where quantity is less than or equal to minStockLevel
      return allItems
          .where((item) => item.quantity <= item.minStockLevel)
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch low stock items: $e');
    }
  }

  /// Update warehouse quantity (inventory adjustment)
  Future<void> updateQuantity(String warehouseId, int newQuantity) async {
    try {
      await _firestore.collection(itemsCollection).doc(warehouseId).update({
        'quantity': newQuantity,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update quantity: $e');
    }
  }

  /// Update order status
  Future<void> updateOrderStatus(
      String warehouseId, String newStatus) async {
    try {
      await _firestore.collection(itemsCollection).doc(warehouseId).update({
        'orderStatus': newStatus,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }

  /// Update delivery status
  Future<void> updateDeliveryStatus(
      String warehouseId, String newStatus) async {
    try {
      await _firestore.collection(itemsCollection).doc(warehouseId).update({
        'deliveryStatus': newStatus,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update delivery status: $e');
    }
  }

  /// Update payment status
  Future<void> updatePaymentStatus(
      String warehouseId, String newStatus) async {
    try {
      await _firestore.collection(itemsCollection).doc(warehouseId).update({
        'paymentStatus': newStatus,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update payment status: $e');
    }
  }

  /// Record delivery
  Future<void> recordDelivery(
      String warehouseId, DateTime deliveryDate) async {
    try {
      await _firestore.collection(itemsCollection).doc(warehouseId).update({
        'actualDeliveryDate': deliveryDate,
        'deliveryStatus': 'delivered',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to record delivery: $e');
    }
  }

  /// Delete warehouse item
  Future<void> deleteWarehouse(String id) async {
    try {
      await _firestore.collection(itemsCollection).doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete warehouse item: $e');
    }
  }

  /// Get real-time updates for a warehouse item
  Stream<WarehouseModel?> watchWarehouse(String id) {
    return _firestore
        .collection(itemsCollection)
        .doc(id)
        .snapshots()
        .map((doc) => doc.exists
            ? WarehouseModel.fromJson(
                doc.data() as Map<String, dynamic>,
                docId: doc.id)
            : null);
  }

  /// Get real-time updates for all warehouse items
  Stream<List<WarehouseModel>> watchAllWarehouses() {
    return _firestore
        .collection(itemsCollection)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => WarehouseModel.fromJson(
                doc.data() as Map<String, dynamic>,
                docId: doc.id))
            .toList());
  }

  /// Get real-time updates for items with pending orders
  Stream<List<WarehouseModel>> watchPendingOrders() {
    return _firestore
        .collection(itemsCollection)
        .where('orderStatus', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => WarehouseModel.fromJson(
                doc.data() as Map<String, dynamic>,
                docId: doc.id))
            .toList());
  }

  /// Get inventory summary statistics
  Future<Map<String, dynamic>> getInventorySummary() async {
    try {
      final snapshot = await _firestore.collection(itemsCollection).get();
      final items = snapshot.docs
          .map((doc) => WarehouseModel.fromJson(
              doc.data() as Map<String, dynamic>,
              docId: doc.id))
          .toList();

      int totalItems = items.length;
      int totalQuantity = items.fold(0, (sum, item) => sum + item.quantity);
      double totalValue =
          items.fold(0.0, (sum, item) => sum + (item.unitCost * item.quantity));
      int lowStockCount =
          items.where((item) => item.quantity <= item.minStockLevel).length;
      int pendingOrdersCount =
          items.where((item) => item.orderStatus == 'pending').length;

      return {
        'totalItems': totalItems,
        'totalQuantity': totalQuantity,
        'totalValue': totalValue,
        'lowStockCount': lowStockCount,
        'pendingOrdersCount': pendingOrdersCount,
        'categories': _getCategories(items),
        'suppliers': _getSuppliers(items),
      };
    } catch (e) {
      throw Exception('Failed to get inventory summary: $e');
    }
  }

  /// Helper method to get unique categories
  List<String> _getCategories(List<WarehouseModel> items) {
    return items
        .map((item) => item.category)
        .where((category) => category.isNotEmpty)
        .toSet()
        .toList();
  }

  /// Helper method to get unique suppliers
  List<String> _getSuppliers(List<WarehouseModel> items) {
    return items
        .map((item) => item.supplierName)
        .where((supplier) => supplier.isNotEmpty)
        .toSet()
        .toList();
  }

  /// Batch update items
  Future<void> batchUpdateWarehouse(List<WarehouseModel> items) async {
    try {
      WriteBatch batch = _firestore.batch();

      for (var item in items) {
        final docRef = _firestore.collection(itemsCollection).doc(item.id);
        batch.set(
            docRef,
            {
              ...item.toJson(),
              'updatedAt': FieldValue.serverTimestamp(),
            },
            SetOptions(merge: true));
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to batch update warehouse items: $e');
    }
  }

  /// Search warehouse items
  Future<List<WarehouseModel>> searchWarehouses(String query) async {
    try {
      final snapshot = await _firestore.collection(itemsCollection).get();
      final allItems = snapshot.docs
          .map((doc) => WarehouseModel.fromJson(
              doc.data() as Map<String, dynamic>,
              docId: doc.id))
          .toList();

      // Filter based on multiple fields
      final lowerQuery = query.toLowerCase();
      return allItems.where((item) {
        return item.itemName.toLowerCase().contains(lowerQuery) ||
            item.sku.toLowerCase().contains(lowerQuery) ||
            item.supplierName.toLowerCase().contains(lowerQuery) ||
            item.purchaseOrderNumber.toLowerCase().contains(lowerQuery) ||
            (item.deliveryOrderNumber?.toLowerCase().contains(lowerQuery) ?? false);
      }).toList();
    } catch (e) {
      throw Exception('Failed to search warehouse items: $e');
    }
  }

  /// Export inventory report
  Future<String> generateInventoryReport() async {
    try {
      final summary = await getInventorySummary();
      final items = await getAllWarehouses();
      final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

      StringBuffer report = StringBuffer();
      report.writeln('=== INVENTORY REPORT ===');
      report.writeln('Generated: ${dateFormat.format(DateTime.now())}');
      report.writeln('');
      report.writeln('SUMMARY:');
      report.writeln('Total Items: ${summary['totalItems']}');
      report.writeln('Total Quantity: ${summary['totalQuantity']}');
      report.writeln('Total Value: \$${summary['totalValue'].toStringAsFixed(2)}');
      report.writeln('Low Stock Items: ${summary['lowStockCount']}');
      report.writeln('Pending Orders: ${summary['pendingOrdersCount']}');
      report.writeln('');
      report.writeln('DETAILED INVENTORY:');
      report.writeln('-' * 100);

      for (var item in items) {
        report.writeln('Item: ${item.itemName}');
        report.writeln('  SKU: ${item.sku}');
        report.writeln('  Quantity: ${item.quantity}');
        report.writeln('  Supplier: ${item.supplierName}');
        report.writeln('  PO #: ${item.purchaseOrderNumber}');
        report.writeln('  DO #: ${item.deliveryOrderNumber ?? 'N/A'}');
        report.writeln('  Status: ${item.orderStatus} / ${item.deliveryStatus}');
        report.writeln('');
      }

      return report.toString();
    } catch (e) {
      throw Exception('Failed to generate inventory report: $e');
    }
  }
}
