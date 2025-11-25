import 'package:craneapplication/features/app_database.dart';
import 'package:craneapplication/features/dao/generic_dao.dart';
import 'package:craneapplication/features/database_items/tables.dart';
import 'package:drift/drift.dart';

class InvoiceDao extends GenericDao<Invoices, Invoice> {
  InvoiceDao(AppDatabase db)
      : super(db, db.invoices, (tbl) => tbl.id as GeneratedColumn<int>);

  Stream<List<Invoice>> watchAllInvoices() => db.select(table).watch();

  Future<List<Invoice>> getAllInvoices() => getAll();

  Future<int> insertInvoice(Insertable<Invoice> invoice) => insert(invoice);

  Future<bool> updateInvoice(Insertable<Invoice> invoice) => update(invoice);

  Future<int> deleteInvoice(Insertable<Invoice> invoice) => delete(invoice);
}
