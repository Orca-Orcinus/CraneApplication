import 'package:craneapplication/features/app_database.dart';
import 'package:craneapplication/features/dao/generic_dao.dart';
import 'package:craneapplication/features/database_items/tables.dart';
import 'package:craneapplication/features/mapper/SupplierMapper.dart';
import 'package:craneapplication/features/entities/SupplierEntity.dart';
import 'package:drift/drift.dart';

/// DAO for Suppliers. Wraps the generic table operations and exposes
/// entity-based helpers using [SupplierMapper].
class SupplierDao extends GenericDao<Suppliers, Supplier> {
  final SupplierMapper mapper;

  SupplierDao(AppDatabase db)
      : mapper = SupplierMapper(),
        super(db, db.suppliers, (tbl) => tbl.id as GeneratedColumn<int>);

  // --- Convenience helper functions returning domain models ---

  /// Returns all suppliers as domain entities.
  Future<List<SupplierEntity>> getAllEntities() async {
    final rows = await getAll();
    return rows.map(mapper.fromRow).toList();
  }

  /// Find domain entity by primary key id.
  Future<SupplierEntity?> findEntityById(int id) async {
    final row = await findbyId(id);
    if (row == null) return null;
    return mapper.fromRow(row);
  }

  /// Update supplier row and propagate important contact fields into
  /// warehouse items that reference this supplier via [supplierRef].
  /// Returns the number of warehouse rows updated.
  Future<int> updateAndPropagate(SupplierEntity entity) async {
    if (entity.id == null) throw ArgumentError('SupplierEntity.id is required to update');

    // update supplier row
    final supComp = mapper.toCompanion(entity);
    await update(supComp);

    // propagate to linked warehouse items
    final rowsUpdated = await (db.update(db.warehouseItems)
          ..where((w) => w.supplierRef.equals(entity.id!)))
        .write(WarehouseItemsCompanion(
      supplierName: Value(entity.name),
      supplierContact: entity.phoneNumber == null ? const Value.absent() : Value(entity.phoneNumber!),
      supplierEmail: entity.email == null ? const Value.absent() : Value(entity.email!),
      supplierPhone: entity.phoneNumber == null ? const Value.absent() : Value(entity.phoneNumber!),
    ));

    return rowsUpdated;
  }

  /// Try to link existing warehouse rows that have supplierId text values
  /// matching this supplier's name. Sets supplierRef for any matches.
  Future<int> linkWarehouseRowsByName(SupplierEntity entity) async {
    if (entity.id == null) throw ArgumentError('SupplierEntity.id is required');

    final matched = await (db.select(db.warehouseItems)
          ..where((w) => w.supplierId.equals(entity.name)))
        .get();

    if (matched.isEmpty) return 0;

    final changes = WarehouseItemsCompanion(supplierRef: Value(entity.id!));
    final updated = await (db.update(db.warehouseItems)
          ..where((w) => w.supplierId.equals(entity.name)))
        .write(changes);

    return updated;
  }
}