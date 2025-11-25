import "package:craneapplication/features/app_database.dart";
import "package:drift/drift.dart";

class GenericDao<T extends Table,D>{
  final AppDatabase db;

  final TableInfo<T,D> table;

  final GeneratedColumn<int> Function(T) idColumnGetter;

  GenericDao(this.db,this.table,this.idColumnGetter);

  Future<int> insert(Insertable<D> entry) => 
    db.into(table).insert(entry);

  Future<bool> update(Insertable<D> entry) =>
    (db.update(table)).replace(entry);

  Future<int> delete(Insertable<D> entry) =>
    db.delete(table).delete(entry);

  Future<List<D>> getAll() => db.select(table).get();

  Future<D?> findbyId(int id){
    final pk = idColumnGetter(table as T);
    return (db.select(table)..where((tbl) => pk.equals(id))).getSingle();
  }

  Future<List<D>> query(Selectable<D> selectable) => selectable.get();

  //Convenience: run a transaction
  Future<TT> transaction<TT>(Future<TT> Function() action) =>
    db.transaction(action);
}

