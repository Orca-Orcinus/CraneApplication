import 'package:drift/drift.dart';

/// Mapper interface: domain entity <-> Drift types
/// TEntity: your domain class (POJO)
/// TRow: the Drift data class (generated)
abstract class EntityMapper<TEntity, TRow> {
  /// Convert Drift row (TRow) to your domain entity
  TEntity fromRow(TRow row);

  /// Convert domain entity to a companion that can be inserted/updated
  /// Return type is Insertable<TRow> (normally SomeTableCompanion)
  Insertable<TRow> toCompanion(TEntity entity);
}
