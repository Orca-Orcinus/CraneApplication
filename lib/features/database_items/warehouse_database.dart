import 'package:drift/drift.dart';

class WarehouseItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get itemId => text().withLength(min: 1, max: 255)();
  IntColumn get supplierRef => integer().nullable().customConstraint('NULL REFERENCES suppliers(id)')();

  TextColumn get itemName => text().withLength(min: 1, max: 255)();
  TextColumn get itemDescription => text().nullable()();
  TextColumn get category => text().withLength(min: 0, max: 255).nullable()();
  TextColumn get sku => text().withLength(min: 0, max: 255).nullable()();
  RealColumn get unitCost => real().withDefault(const Constant(0.0))();

  TextColumn get supplierName => text().withLength(min: 0, max: 255).nullable()();
  TextColumn get supplierContact => text().nullable()();
  TextColumn get supplierEmail => text().nullable()();
  TextColumn get supplierPhone => text().nullable()();

  IntColumn get quantity => integer().withDefault(const Constant(0))();
  IntColumn get minStockLevel => integer().withDefault(const Constant(0))();
  IntColumn get maxStockLevel => integer().withDefault(const Constant(1000))();
  TextColumn get unit => text().withLength(min: 0, max: 50).withDefault(const Constant('pcs'))();
  TextColumn get warehouseLocation => text().nullable()();

  TextColumn get purchaseOrderNumber => text().nullable()();
  TextColumn get deliveryOrderNumber => text().nullable()();

  DateTimeColumn get purchaseOrderDate => dateTime().nullable()();
  DateTimeColumn get expectedDeliveryDate => dateTime().nullable()();
  DateTimeColumn get actualDeliveryDate => dateTime().nullable()();

  TextColumn get orderStatus => text().withDefault(const Constant('pending'))();
  TextColumn get deliveryStatus => text().withDefault(const Constant('not_ordered'))();

  RealColumn get totalAmount => real().withDefault(const Constant(0.0))();
  TextColumn get paymentStatus => text().withDefault(const Constant('unpaid'))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  TextColumn get createdBy => text().withLength(min: 0, max: 255).nullable()();
  TextColumn get notes => text().nullable()();

  // sync metadata
  TextColumn get remoteId => text().named('remote_id').nullable()();
  DateTimeColumn get lastModified => dateTime().named('last_modified').nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false)).named('deleted')();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(false)).named('pending_sync')();
}
