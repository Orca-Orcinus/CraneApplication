import 'package:craneapplication/features/app_database.dart';
import 'package:craneapplication/features/dao/generic_dao.dart';
import 'package:craneapplication/features/database_items/tables.dart';
import 'package:drift/drift.dart';

class VehicleTypeDao extends GenericDao<VehicleType, VehicleTypeData> {
  VehicleTypeDao(AppDatabase db) : super(db, db.vehicleType, (tbl) => tbl.id as GeneratedColumn<int>);

  Stream<List<VehicleTypeData>> watchAllTypes() => db.select(table).watch();

  Future<List<VehicleTypeData>> getAllTypes() => getAll();

  Future<int> insertType(Insertable<VehicleTypeData> type) => insert(type);

  Future<bool> updateType(Insertable<VehicleTypeData> type) => update(type);

  Future<int> deleteType(Insertable<VehicleTypeData> type) => delete(type);
}
