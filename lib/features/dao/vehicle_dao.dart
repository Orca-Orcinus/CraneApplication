import 'package:craneapplication/features/app_database.dart';
import 'package:craneapplication/features/dao/generic_dao.dart';
import 'package:craneapplication/features/database_items/tables.dart';
import 'package:drift/drift.dart';

class VehicleDao extends GenericDao<Vehicles, Vehicle> {
  VehicleDao(AppDatabase db) : super(db, db.vehicles, (tbl) => tbl.id as GeneratedColumn<int>);

  Stream<List<Vehicle>> watchAllVehicles() => db.select(table).watch();

  Future<List<Vehicle>> getAllVehicles() => getAll();

  Future<int> insertVehicle(Insertable<Vehicle> vehicle) => insert(vehicle);

  Future updateVehicle(Insertable<Vehicle> vehicle) => update(vehicle);

  Future<int> deleteVehicle(Insertable<Vehicle> vehicle) => delete(vehicle);
}
