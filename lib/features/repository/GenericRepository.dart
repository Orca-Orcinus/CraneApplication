import 'package:craneapplication/features/dao/generic_dao.dart';
import 'package:craneapplication/features/mapper/EntityMapper.dart';
import 'package:drift/drift.dart';

class GenericRepository<TEntity,TRow> {
  final GenericDao dao;
  final EntityMapper<TEntity,TRow> mapper;

  GenericRepository(this.dao,this.mapper);

  Future<int> insert(TEntity entity) =>
    dao.insert(mapper.toCompanion(entity));

  Future<bool> update(TEntity entity) =>
    dao.update(mapper.toCompanion(entity));

  Future<int> deleteByCompanion(Insertable<TRow> companion) =>
    dao.delete(companion);

  Future<void> deleteById(int id) async {
    final row = await dao.findbyId(id) as TRow;
    if (row != null) {
      await dao.db.delete(dao.table).delete(row as dynamic);
    }
  }

  Future<List<TEntity>> getAll() async {
    final rows = await dao.getAll();
    return rows.map((row) => mapper.fromRow(row)).toList();
  }

  Future<TEntity?> findById(int id) async {
    final row = await dao.findbyId(id);
    if (row == null) return null;
    return mapper.fromRow(row);
  }
}