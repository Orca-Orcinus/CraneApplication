import 'package:craneapplication/features/mapper/EntityMapper.dart';
import 'package:drift/drift.dart';
import '../entities/SupplierEntity.dart';
import '../app_database.dart';

class SupplierMapper implements EntityMapper<SupplierEntity,Supplier> {
  @override
  SupplierEntity fromRow(Supplier row) {
    return SupplierEntity(
      id: row.id,
      name: row.name,
      phoneNumber: row.phoneNumber,
      email: row.email,
      address: row.address,
    );
  }

  @override
  Insertable<Supplier> toCompanion(SupplierEntity entity) {
    return SuppliersCompanion(      
      id: entity.id != null ? Value(entity.id!) : const Value.absent(),
      name: Value(entity.name),
      phoneNumber: Value(entity.phoneNumber),
      email: Value(entity.email),
      address: Value(entity.address),
    );
  }
}