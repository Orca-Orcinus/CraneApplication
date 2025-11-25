import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

/// Web/wasm implementation of the database connection used when compiling
/// for the web. This file will only be imported on web builds via conditional
/// imports from `app_database.dart`.
LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final result = await WasmDatabase.open(
      databaseName: 'crane_warehouse_db',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );

    return result.resolvedExecutor;
  });
}
