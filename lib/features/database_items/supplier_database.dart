import 'package:drift/drift.dart';

class Suppliers extends Table
{
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 255)();

  TextColumn get phoneNumber => text().withLength(min: 1, max: 20).nullable()();

  TextColumn get email => text().withLength(min: 1, max: 255).nullable()();

  TextColumn get address => text().withLength(min: 1, max: 500).nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  // sync metadata
  TextColumn get remoteId => text().named('remote_id').nullable()();
  DateTimeColumn get lastModified => dateTime().named('last_modified').nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false)).named('deleted')();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(false)).named('pending_sync')();
}

class SupplierProducts extends Table
{
  IntColumn get id => integer().autoIncrement()();

  TextColumn get productName => text().withLength(min: 1, max: 255)();

  TextColumn get description => text().withLength(min: 1, max: 1000).nullable()();

  RealColumn get price => real().withDefault(const Constant(0.0))();

  IntColumn get stockQuantity => integer().withDefault(const Constant(0))();

  IntColumn get supplierId => integer().references(Suppliers, #id)();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  TextColumn get updatedBy => text().withLength(min: 1, max: 255).nullable()();

  // sync metadata
  TextColumn get remoteId => text().named('remote_id').nullable()();
  DateTimeColumn get lastModified => dateTime().named('last_modified').nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false)).named('deleted')();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(false)).named('pending_sync')();
}

class PurchaseOrder extends Table
{
  IntColumn get id => integer().autoIncrement()();

  IntColumn get supplierId => integer().references(Suppliers, #id)();

  IntColumn get purchaseQuantity => integer().withDefault(const Constant(1))();

  DateTimeColumn get orderDate => dateTime().withDefault(currentDateAndTime)();

  RealColumn get totalAmount => real().withDefault(const Constant(0.0))();

  // sync metadata
  TextColumn get remoteId => text().named('remote_id').nullable()();
  DateTimeColumn get lastModified => dateTime().named('last_modified').nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false)).named('deleted')();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(false)).named('pending_sync')();
}

class PurchaseOrderItems extends Table
{
  IntColumn get id => integer().autoIncrement()();

  IntColumn get purchaseOrderId => integer().references(PurchaseOrder, #id, onDelete: KeyAction.cascade )();

  IntColumn get productId => integer().references(SupplierProducts, #id)();

  IntColumn get orderedQuantity => integer().withDefault(const Constant(0))();

  RealColumn get lineTotal => real().withDefault(const Constant(0.0))();
}

class DeliverOrder extends Table
{
  IntColumn get id => integer().autoIncrement()();

  IntColumn get supplierId => integer().references(Suppliers, #id)();

  IntColumn get deliveryQuantity => integer().withDefault(const Constant(0))();

  DateTimeColumn get deliveryDate => dateTime().withDefault(currentDateAndTime)();

  RealColumn get totalAmount => real().withDefault(const Constant(0.0))();

  BoolColumn get pendingSync => boolean().withDefault(const Constant(false))();
}

class DeliverOrderItems extends Table
{
  IntColumn get id => integer().autoIncrement()();

  IntColumn get deliveryOrderId => integer().references(DeliverOrder, #id, onDelete: KeyAction.cascade )();

  IntColumn get productId => integer().references(SupplierProducts, #id)();

  IntColumn get deliveredQuantity => integer().withDefault(const Constant(0))();

  RealColumn get lineTotal => real().withDefault(const Constant(0.0))();
}