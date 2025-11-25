
import 'package:drift/drift.dart';

class Customers extends Table
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
