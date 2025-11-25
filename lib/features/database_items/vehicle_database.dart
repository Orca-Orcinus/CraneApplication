import 'package:drift/drift.dart';

class Vehicles extends Table
{
  IntColumn get id => integer().autoIncrement()();

  TextColumn get vehicleNumber => text().withLength(min: 1, max: 50)();

  TextColumn get vehicleModel => text().references(VehicleType, #typeName)();
  // sync metadata
  TextColumn get remoteId => text().named('remote_id').nullable()();
  DateTimeColumn get lastModified => dateTime().named('last_modified').nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false)).named('deleted')();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(false)).named('pending_sync')();
}

class VehicleType extends Table
{
  IntColumn get id => integer().autoIncrement()();

  TextColumn get typeName => text().withLength(min: 1, max: 100)();
  // sync metadata for types
  TextColumn get remoteId => text().named('remote_id').nullable()();
  DateTimeColumn get lastModified => dateTime().named('last_modified').nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false)).named('deleted')();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(false)).named('pending_sync')();
}