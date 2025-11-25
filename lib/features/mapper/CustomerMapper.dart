import 'package:drift/drift.dart';
import '../app_database.dart';
import '../entities/CustomerEntity.dart';
import 'EntityMapper.dart';

class CustomerMapper implements EntityMapper<CustomerEntity, Customer> {
  @override
  CustomerEntity fromRow(Customer row) {
    return CustomerEntity(
      id: row.id,
      name: row.name,
      address: row.address,
      phoneNumber: row.phoneNumber,
      emailAddress: row.email,
    );
  }

  @override
  Insertable<Customer> toCompanion(CustomerEntity entity) {
    return CustomersCompanion(      
      id: entity.id != null ? Value(entity.id!) : const Value.absent(),
      name: Value(entity.name),
      address: Value(entity.address),
      phoneNumber: Value(entity.phoneNumber),
      email: Value(entity.emailAddress),
    );
  }
}