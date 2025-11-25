import 'package:craneapplication/features/app_database.dart';
import 'package:craneapplication/features/dao/generic_dao.dart';
import 'package:craneapplication/features/mapper/CustomerMapper.dart';
import 'package:craneapplication/features/database_items/tables.dart';
import 'package:drift/drift.dart';
import 'package:craneapplication/features/entities/CustomerEntity.dart';
 

/// DAO for Customers using GenericDao and CustomerMapper to provide
/// entity-level helpers for the rest of the app.
class CustomerDao extends GenericDao<Customers, Customer> {
  final CustomerMapper mapper;

  CustomerDao(AppDatabase db)
      : mapper = CustomerMapper(),
        super(db, db.customers, (tbl) => tbl.id as GeneratedColumn<int>);

  Future<List<CustomerEntity>> getAllEntities() async {
    final rows = await getAll();
    return rows.map(mapper.fromRow).toList();
  }

  Stream<List<CustomerEntity>> watchAllEntities() {
    return db.select(table).watch().map((rows) => rows.map(mapper.fromRow).toList());
  }

  Future<int> insertEntity(CustomerEntity entity) async {
    final companion = mapper.toCompanion(entity);
    return insert(companion);
  }

  Future<bool> updateEntity(CustomerEntity entity) async {
    final companion = mapper.toCompanion(entity);
    return update(companion);
  }

  Future<int> deleteEntity(CustomerEntity entity) async {
    final companion = mapper.toCompanion(entity);
    return delete(companion);
  }

  Future<CustomerEntity?> findEntityById(int id) async {
    final row = await findbyId(id);
    if (row == null) return null;
    return mapper.fromRow(row);
  }
}
