import 'package:craneapplication/features/app_database.dart';
import 'package:craneapplication/features/auth/firebasestore.dart';
import 'package:drift/drift.dart' show Value;

/// Small, pragmatic SyncService to push/pull core tables between the local
/// Drift DB and a Firestore collection. This is intentionally conservative
/// (works with small datasets) and aims to be easy to extend.
class SyncService {
  final AppDatabase db;
  final FireStoreService remote;

  SyncService(this.db, this.remote);

  Future<void> syncAll() async {
    await syncSuppliers();
    await syncCustomers();
    await syncVehicles();
    await syncInvoices();
    await syncWarehouses();
  }

  // ---------- Warehouses ----------
  Future<void> syncWarehouses() async {
    const collection = 'warehouse_items';

    // Pull remote docs
    final remoteRows = await remote.getData(collection: collection);

    for (final doc in remoteRows) {
      try {
        final data = Map<String, dynamic>.from(doc)..remove('id');

        // Identify a local row. We prefer `localId` mapping (stored when we push)
        final localId = data['localId'];
        WarehouseItem? local;
        if (localId != null) {
          local = await (db.select(db.warehouseItems)..where((t) => t.id.equals(localId))).getSingleOrNull();
        } else if (data['itemId'] != null) {
          final list = await (db.select(db.warehouseItems)..where((t) => t.itemId.equals(data['itemId'] as String))).get();
          local = list.isNotEmpty ? list.first : null;
        }

        if (local == null) {
          // Insert local copy
          final companion = WarehouseItemsCompanion(
            itemId: Value(data['itemId']?.toString() ?? ''),
            itemName: Value(data['itemName']?.toString() ?? ''),
            itemDescription: Value(data['itemDescription']?.toString()),
            category: Value(data['category']?.toString()),
            sku: Value(data['sku']?.toString()),
            unitCost: Value((data['unitCost'] as num?)?.toDouble() ?? 0.0),
            supplierName: Value(data['supplierName']?.toString()),
            supplierContact: Value(data['supplierContact']?.toString()),
            supplierEmail: Value(data['supplierEmail']?.toString()),
            supplierPhone: Value(data['supplierPhone']?.toString()),
            quantity: Value((data['quantity'] as num?)?.toInt() ?? 0),
            minStockLevel: Value((data['minStockLevel'] as num?)?.toInt() ?? 0),
            maxStockLevel: Value((data['maxStockLevel'] as num?)?.toInt() ?? 1000),
            unit: Value(data['unit']?.toString() ?? 'pcs'),
            warehouseLocation: Value(data['warehouseLocation']?.toString()),
            purchaseOrderNumber: Value(data['purchaseOrderNumber']?.toString()),
            deliveryOrderNumber: Value(data['deliveryOrderNumber']?.toString()),
            orderStatus: Value(data['orderStatus']?.toString() ?? 'pending'),
            deliveryStatus: Value(data['deliveryStatus']?.toString() ?? 'not_ordered'),
            totalAmount: Value((data['totalAmount'] as num?)?.toDouble() ?? 0.0),
            paymentStatus: Value(data['paymentStatus']?.toString() ?? 'unpaid'),
            createdAt: Value(DateTime.tryParse(data['createdAt']?.toString() ?? '') ?? DateTime.now()),
            updatedAt: Value(DateTime.tryParse(data['updatedAt']?.toString() ?? '') ?? DateTime.now()),
            createdBy: Value(data['createdBy']?.toString()),
            notes: Value(data['notes']?.toString()),
          );

          await db.into(db.warehouseItems).insert(companion);
        } else {
          // Compare timestamps and update if remote is newer
          final remoteUpdated = _parseTimestamp(data['updatedAt']);
          final localUpdated = local.updatedAt ?? local.createdAt;
          if (remoteUpdated != null && remoteUpdated.isAfter(localUpdated)) {
            final updateComp = WarehouseItemsCompanion(
              itemName: Value(data['itemName']?.toString() ?? local.itemName),
              itemDescription: Value(data['itemDescription']?.toString() ?? local.itemDescription),
              category: Value(data['category']?.toString() ?? local.category),
              sku: Value(data['sku']?.toString() ?? local.sku),
              unitCost: Value((data['unitCost'] as num?)?.toDouble() ?? local.unitCost),
              supplierName: Value(data['supplierName']?.toString() ?? local.supplierName),
              supplierContact: Value(data['supplierContact']?.toString() ?? local.supplierContact),
              supplierEmail: Value(data['supplierEmail']?.toString() ?? local.supplierEmail),
              supplierPhone: Value(data['supplierPhone']?.toString() ?? local.supplierPhone),
              quantity: Value((data['quantity'] as num?)?.toInt() ?? local.quantity),
              minStockLevel: Value((data['minStockLevel'] as num?)?.toInt() ?? local.minStockLevel),
              maxStockLevel: Value((data['maxStockLevel'] as num?)?.toInt() ?? local.maxStockLevel),
              unit: Value(data['unit']?.toString() ?? local.unit),
              warehouseLocation: Value(data['warehouseLocation']?.toString() ?? local.warehouseLocation),
              purchaseOrderNumber: Value(data['purchaseOrderNumber']?.toString() ?? local.purchaseOrderNumber),
              deliveryOrderNumber: Value(data['deliveryOrderNumber']?.toString() ?? local.deliveryOrderNumber),
              orderStatus: Value(data['orderStatus']?.toString() ?? local.orderStatus),
              deliveryStatus: Value(data['deliveryStatus']?.toString() ?? local.deliveryStatus),
              totalAmount: Value((data['totalAmount'] as num?)?.toDouble() ?? local.totalAmount),
              paymentStatus: Value(data['paymentStatus']?.toString() ?? local.paymentStatus),
              updatedAt: Value(remoteUpdated),
              createdBy: Value(data['createdBy']?.toString() ?? local.createdBy),
              notes: Value(data['notes']?.toString() ?? local.notes),
            );

              await (db.update(db.warehouseItems)..where((t) => t.id.equals(local!.id))).write(updateComp);
          }
        }
      } catch (e) {
        // best effort: log and continue
        print('syncWarehouses: failed to apply remote row ${doc['id']}: $e');
      }
    }

    // Push local rows which look newer than remote or haven't been pushed.
    final locals = await db.select(db.warehouseItems).get();
    // not used currently; keep plan to optimize by indexing remote rows in memory

    for (final local in locals) {
      try {
        // find remote mapping by localId
        final match = _firstWhereOrNull<Map<String, dynamic>>(remoteRows.cast<Map<String, dynamic>>(),
          (r) => (r['localId']?.toString() ?? '') == local.id.toString());

        final payload = {
          'localId': local.id,
          'itemId': local.itemId,
          'itemName': local.itemName,
          'itemDescription': local.itemDescription,
          'category': local.category,
          'sku': local.sku,
          'unitCost': local.unitCost,
          'supplierName': local.supplierName,
          'supplierContact': local.supplierContact,
          'supplierEmail': local.supplierEmail,
          'supplierPhone': local.supplierPhone,
          'quantity': local.quantity,
          'minStockLevel': local.minStockLevel,
          'maxStockLevel': local.maxStockLevel,
          'unit': local.unit,
          'warehouseLocation': local.warehouseLocation,
          'purchaseOrderNumber': local.purchaseOrderNumber,
          'deliveryOrderNumber': local.deliveryOrderNumber,
          'orderStatus': local.orderStatus,
          'deliveryStatus': local.deliveryStatus,
          'totalAmount': local.totalAmount,
          'paymentStatus': local.paymentStatus,
          'createdAt': local.createdAt.toIso8601String(),
          'updatedAt': (local.updatedAt ?? local.createdAt).toIso8601String(),
          'createdBy': local.createdBy,
          'notes': local.notes,
        };

        if (match == null) {
          await remote.addData(collection: collection, data: payload);
        } else {
          final docId = match['id'] as String;
          await remote.updateData(collection: collection, documentId: docId, data: payload);
        }
      } catch (e) {
        print('syncWarehouses: failed to push local row ${local.id}: $e');
      }
    }
  }

  // ---------- Suppliers ----------
  Future<void> syncSuppliers() async {
    const collection = 'suppliers';
    final remoteRows = await remote.getData(collection: collection);

    // Pull (remote -> local)
    for (final doc in remoteRows) {
      try {
        final data = Map<String, dynamic>.from(doc)..remove('id');
        final localId = data['localId'];
        Supplier? local;
        if (localId != null) {
          local = await (db.select(db.suppliers)..where((t) => t.id.equals(localId))).getSingleOrNull();
        } else if (data['name'] != null) {
          final list = await (db.select(db.suppliers)..where((t) => t.name.equals(data['name'] as String))).get();
          local = list.isNotEmpty ? list.first : null;
        }

        if (local == null) {
          final comp = SuppliersCompanion(
            name: Value(data['name']?.toString() ?? ''),
            phoneNumber: Value(data['phoneNumber']?.toString()),
            email: Value(data['email']?.toString()),
            address: Value(data['address']?.toString()),
            createdAt: Value(DateTime.tryParse(data['createdAt']?.toString() ?? '') ?? DateTime.now()),
            pendingSync: Value(false),
          );
          await db.into(db.suppliers).insert(comp);
        } else {
          // no-op unless remote is newer - suppliers table doesn't track updatedAt widely in schema
        }
      } catch (e) {
        print('syncSuppliers: failed to apply remote row ${doc['id']}: $e');
      }
    }

    // Push locals
    final locals = await db.select(db.suppliers).get();
    for (final local in locals) {
      try {
        final match = _firstWhereOrNull<Map<String, dynamic>>(remoteRows.cast<Map<String, dynamic>>(), (r) => (r['localId']?.toString() ?? '') == local.id.toString());
        final payload = {
          'localId': local.id,
          'name': local.name,
          'phoneNumber': local.phoneNumber,
          'email': local.email,
          'address': local.address,
          'createdAt': local.createdAt.toIso8601String(),
        };

        if (match == null) {
          await remote.addData(collection: collection, data: payload);
        } else {
          await remote.updateData(collection: collection, documentId: match['id'] as String, data: payload);
        }
      } catch (e) {
        print('syncSuppliers: failed to push local row ${local.id}: $e');
      }
    }
  }

  // ---------- Customers ----------
  Future<void> syncCustomers() async {
    const collection = 'customers';
    final remoteRows = await remote.getData(collection: collection);
    final locals = await db.select(db.customers).get();

    // pull
    for (final doc in remoteRows) {
      try {
        final data = Map<String, dynamic>.from(doc)..remove('id');
        final localId = data['localId'];
        Customer? local;
        if (localId != null) {
          local = await (db.select(db.customers)..where((t) => t.id.equals(localId))).getSingleOrNull();
        } else if (data['name'] != null) {
          final list = await (db.select(db.customers)..where((t) => t.name.equals(data['name'] as String))).get();
          local = list.isNotEmpty ? list.first : null;
        }

        if (local == null) {
          final comp = CustomersCompanion(
            name: Value(data['name']?.toString() ?? ''),
            phoneNumber: Value(data['phoneNumber']?.toString()),
            email: Value(data['email']?.toString()),
            address: Value(data['address']?.toString()),
            createdAt: Value(DateTime.tryParse(data['createdAt']?.toString() ?? '') ?? DateTime.now()),
            pendingSync: Value(false),
          );
          await db.into(db.customers).insert(comp);
        }
      } catch (e) {
        print('syncCustomers: failed to apply remote row ${doc['id']}: $e');
      }
    }

    // push
    for (final local in locals) {
      try {
        final match = _firstWhereOrNull<Map<String, dynamic>>(remoteRows.cast<Map<String, dynamic>>(), (r) => (r['localId']?.toString() ?? '') == local.id.toString());
        final payload = {
          'localId': local.id,
          'name': local.name,
          'phoneNumber': local.phoneNumber,
          'email': local.email,
          'address': local.address,
          'createdAt': local.createdAt.toIso8601String(),
        };

        if (match == null) {
          await remote.addData(collection: collection, data: payload);
        } else {
          await remote.updateData(collection: collection, documentId: match['id'] as String, data: payload);
        }
      } catch (e) {
        print('syncCustomers: failed to push local row ${local.id}: $e');
      }
    }
  }

  // ---------- Invoices ----------
  Future<void> syncInvoices() async {
    const collection = 'invoices';
    final remoteRows = await remote.getData(collection: collection);
    final locals = await db.select(db.invoices).get();

    for (final doc in remoteRows) {
      try {
        final data = Map<String, dynamic>.from(doc)..remove('id');
        final localId = data['localId'];
        Invoice? local;
        if (localId != null) {
          local = await (db.select(db.invoices)..where((t) => t.id.equals(localId))).getSingleOrNull();
        }

        if (local == null) {
          // required fields check
          if (data['customerId'] == null || data['vehicleNumber'] == null) continue;

          final comp = InvoicesCompanion(
            customerId: Value((data['customerId'] as num).toInt()),
            vehicleNumber: Value((data['vehicleNumber'] as String)),
            serviceDateTime: Value(DateTime.tryParse(data['serviceDateTime']?.toString() ?? '') ?? DateTime.now()),
            invoiceDate: Value(DateTime.tryParse(data['invoiceDate']?.toString() ?? '') ?? DateTime.now()),
            totalAmount: Value((data['totalAmount'] as num?)?.toDouble() ?? 0.0),
            pendingSync: Value(false),
          );
          await db.into(db.invoices).insert(comp);
        }
      } catch (e) {
        print('syncInvoices: failed to apply remote row ${doc['id']}: $e');
      }
    }

    for (final local in locals) {
      try {
        final match = _firstWhereOrNull<Map<String, dynamic>>(remoteRows.cast<Map<String, dynamic>>(), (r) => (r['localId']?.toString() ?? '') == local.id.toString());
        final payload = {
          'localId': local.id,
          'customerId': local.customerId,
          'vehicleNumber': local.vehicleNumber,
          'serviceDateTime': local.serviceDateTime.toIso8601String(),
          'invoiceDate': local.invoiceDate.toIso8601String(),
          'totalAmount': local.totalAmount,
        };

        if (match == null) {
          await remote.addData(collection: collection, data: payload);
        } else {
          await remote.updateData(collection: collection, documentId: match['id'] as String, data: payload);
        }
      } catch (e) {
        print('syncInvoices: failed to push local row ${local.id}: $e');
      }
    }
  }

  // ---------- Vehicles & Types ----------
  Future<void> syncVehicles() async {
    const vehiclesCollection = 'vehicles';
    const typesCollection = 'vehicle_types';

    // types
    final remoteTypes = await remote.getData(collection: typesCollection);
    for (final doc in remoteTypes) {
      try {
        final data = Map<String, dynamic>.from(doc)..remove('id');
        final list = await (db.select(db.vehicleType)..where((t) => t.typeName.equals(data['typeName']?.toString() ?? ''))).get();
        final match = list.isNotEmpty ? list.first : null;
        if (match == null) {
          await db.into(db.vehicleType).insert(VehicleTypeCompanion(typeName: Value(data['typeName']?.toString() ?? '')));
        }
      } catch (e) {
        print('syncVehicles: failed applying remote type ${doc['id']}: $e');
      }
    }

    // vehicles
    final remoteVehicles = await remote.getData(collection: vehiclesCollection);
    for (final doc in remoteVehicles) {
      try {
        final data = Map<String, dynamic>.from(doc)..remove('id');
        final vlist = await (db.select(db.vehicles)..where((t) => t.vehicleNumber.equals(data['vehicleNumber']?.toString() ?? ''))).get();
        final match = vlist.isNotEmpty ? vlist.first : null;
        if (match == null) {
          final comp = VehiclesCompanion(
            vehicleNumber: Value(data['vehicleNumber']?.toString() ?? ''),
            vehicleModel: data['vehicleModel'] != null ? Value((data['vehicleModel'] as String)) : const Value.absent(),
          );
          await db.into(db.vehicles).insert(comp);
        }
      } catch (e) {
        print('syncVehicles: failed applying remote vehicle ${doc['id']}: $e');
      }
    }
  }

  // small helper
  DateTime? _parseTimestamp(Object? value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  // small generic helper: firstWhereOrNull replacement (avoids using collection package)
  T? _firstWhereOrNull<T>(Iterable<T> items, bool Function(T) test) {
    for (final e in items) {
      if (test(e)) return e;
    }
    return null;
  }
}
