import 'package:craneapplication/features/mapper/EntityMapper.dart';
import 'package:craneapplication/features/app_database.dart';
import '../../Model/WarehouseTool/WarehouseModel.dart';
import 'package:drift/drift.dart';

class WarehouseMapper implements EntityMapper<WarehouseModel, WarehouseItem> {
  @override
  WarehouseModel fromRow(WarehouseItem row) {
    return WarehouseModel.fromDb(row);
  }

  @override
  Insertable<WarehouseItem> toCompanion(WarehouseModel entity) {
    return entity.toCompanion();
  }
}
