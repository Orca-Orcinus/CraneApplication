import 'package:craneapplication/features/app_database.dart';
import 'package:craneapplication/features/database_items/tables.dart';
import 'package:craneapplication/features/dao/generic_dao.dart';
import 'package:drift/drift.dart';

class WarehouseDao extends GenericDao<WarehouseItems, WarehouseItem> {
  WarehouseDao(AppDatabase db) : super(db, db.warehouseItems, (tbl) => tbl.id as GeneratedColumn<int>);

  Stream<List<WarehouseItem>> watchAll() => db.select(table).watch();
  Future<List<WarehouseItem>> getAllItems() => getAll();
  Future<int> insertItem(Insertable<WarehouseItem> item) => insert(item);
  Future<bool> updateItem(Insertable<WarehouseItem> item) => update(item);
  Future<int> deleteItem(Insertable<WarehouseItem> item) => delete(item);

  Future<List<WarehouseItem>> getWarehouseItemsByName(String name) {
    return (db.select(table)..where((tbl) => tbl.itemName.equals(name))).get();
  }

  Future<List<WarehouseItem>> getWarehouseItemsBySupplierRef(int supplierRefId) {
    return (db.select(table)..where((tbl) => tbl.supplierRef.equals(supplierRefId))).get();
  }

  Future<List<WarehouseItem>> getWarehousesByOrderStatus(String status) {
    return (db.select(table)..where((tbl) => tbl.orderStatus.equals(status))).get();
  }

  Future<List<WarehouseItem>> getLowStockItems() {
    return (db.select(table)..where((tbl) => (tbl.quantity.isSmallerOrEqual(tbl.minStockLevel)))).get();
  }
}
