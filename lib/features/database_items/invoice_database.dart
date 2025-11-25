
import 'package:craneapplication/features/database_items/customer_database.dart';
import 'package:craneapplication/features/database_items/vehicle_database.dart';
import 'package:drift/drift.dart';

class Invoices extends Table
{
  IntColumn get id => integer().autoIncrement()();

  IntColumn get customerId => integer().references(Customers, #id)();

  TextColumn get vehicleNumber => text().references(Vehicles, #vehicleNumber)();

  DateTimeColumn get serviceDateTime => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get invoiceDate => dateTime().withDefault(currentDateAndTime)();

  RealColumn get totalAmount => real().withDefault(const Constant(0.0))();
  // sync metadata
  TextColumn get remoteId => text().named('remote_id').nullable()();
  DateTimeColumn get lastModified => dateTime().named('last_modified').nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false)).named('deleted')();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(false)).named('pending_sync')();
}

class WorkOrder extends Table
{
  IntColumn get id => integer().autoIncrement()();

  IntColumn get workOrderNo => integer()();

  TextColumn get description => text().withLength(min: 1, max: 1000)();

  RealColumn get laborCost => real().withDefault(const Constant(0.0))();

  RealColumn get partsCost => real().withDefault(const Constant(0.0))();
  // sync metadata
  TextColumn get remoteId => text().named('remote_id').nullable()();
  DateTimeColumn get lastModified => dateTime().named('last_modified').nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false)).named('deleted')();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(false)).named('pending_sync')();
}