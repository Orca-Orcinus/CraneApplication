import 'package:drift/drift.dart';

class SyncMetadata extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get collection => text().withLength(min: 1, max: 255)();
  DateTimeColumn get lastSyncedAt => dateTime().nullable().named('last_synced_at')();
  // Optional JSON payload for arbitrary metadata
  TextColumn get metadataJson => text().nullable().named('metadata_json')();
}
