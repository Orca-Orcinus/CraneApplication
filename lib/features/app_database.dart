import "package:craneapplication/features/database_items/tables.dart";
import 'package:drift/drift.dart';

// Use conditional imports so web-only wasm code is not compiled for native targets
// (android/ios/windows). The files provide a platform-specific
// `_openConnection()` implementation.
import 'package:craneapplication/features/app_database_connection_io.dart'
  if (dart.library.html) 'package:craneapplication/features/app_database_connection_web.dart';

part 'app_database.g.dart';

// The platform-specific `_openConnection()` is provided by one of the
// conditional imports above.


@DriftDatabase(
  tables: [WarehouseItems, Invoices, Customers, Suppliers, Vehicles, VehicleType],
)

class AppDatabase extends _$AppDatabase {
  static AppDatabase? _instance;

  AppDatabase._internal() : super(openConnection());

  factory AppDatabase() {
    _instance ??= AppDatabase._internal();
    return _instance!;
  }

  @override
  int get schemaVersion => 2;
    
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
      await m.createAll();
    },
        onUpgrade: (m, from, to) async {
      // Migration logic goes here
    },
  );
}
