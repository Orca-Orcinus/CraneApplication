// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WarehouseItemsTable extends WarehouseItems
    with TableInfo<$WarehouseItemsTable, WarehouseItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WarehouseItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
      'item_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _supplierIdMeta =
      const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
      'supplier_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _supplierRefMeta =
      const VerificationMeta('supplierRef');
  @override
  late final GeneratedColumn<int> supplierRef = GeneratedColumn<int>(
      'supplier_ref', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NULL REFERENCES suppliers(id)');
  static const VerificationMeta _itemNameMeta =
      const VerificationMeta('itemName');
  @override
  late final GeneratedColumn<String> itemName = GeneratedColumn<String>(
      'item_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _itemDescriptionMeta =
      const VerificationMeta('itemDescription');
  @override
  late final GeneratedColumn<String> itemDescription = GeneratedColumn<String>(
      'item_description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _unitCostMeta =
      const VerificationMeta('unitCost');
  @override
  late final GeneratedColumn<double> unitCost = GeneratedColumn<double>(
      'unit_cost', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _supplierNameMeta =
      const VerificationMeta('supplierName');
  @override
  late final GeneratedColumn<String> supplierName = GeneratedColumn<String>(
      'supplier_name', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _supplierContactMeta =
      const VerificationMeta('supplierContact');
  @override
  late final GeneratedColumn<String> supplierContact = GeneratedColumn<String>(
      'supplier_contact', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _supplierEmailMeta =
      const VerificationMeta('supplierEmail');
  @override
  late final GeneratedColumn<String> supplierEmail = GeneratedColumn<String>(
      'supplier_email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _supplierPhoneMeta =
      const VerificationMeta('supplierPhone');
  @override
  late final GeneratedColumn<String> supplierPhone = GeneratedColumn<String>(
      'supplier_phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _minStockLevelMeta =
      const VerificationMeta('minStockLevel');
  @override
  late final GeneratedColumn<int> minStockLevel = GeneratedColumn<int>(
      'min_stock_level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _maxStockLevelMeta =
      const VerificationMeta('maxStockLevel');
  @override
  late final GeneratedColumn<int> maxStockLevel = GeneratedColumn<int>(
      'max_stock_level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1000));
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pcs'));
  static const VerificationMeta _warehouseLocationMeta =
      const VerificationMeta('warehouseLocation');
  @override
  late final GeneratedColumn<String> warehouseLocation =
      GeneratedColumn<String>('warehouse_location', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _purchaseOrderNumberMeta =
      const VerificationMeta('purchaseOrderNumber');
  @override
  late final GeneratedColumn<String> purchaseOrderNumber =
      GeneratedColumn<String>('purchase_order_number', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deliveryOrderNumberMeta =
      const VerificationMeta('deliveryOrderNumber');
  @override
  late final GeneratedColumn<String> deliveryOrderNumber =
      GeneratedColumn<String>('delivery_order_number', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _purchaseOrderDateMeta =
      const VerificationMeta('purchaseOrderDate');
  @override
  late final GeneratedColumn<DateTime> purchaseOrderDate =
      GeneratedColumn<DateTime>('purchase_order_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _expectedDeliveryDateMeta =
      const VerificationMeta('expectedDeliveryDate');
  @override
  late final GeneratedColumn<DateTime> expectedDeliveryDate =
      GeneratedColumn<DateTime>('expected_delivery_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _actualDeliveryDateMeta =
      const VerificationMeta('actualDeliveryDate');
  @override
  late final GeneratedColumn<DateTime> actualDeliveryDate =
      GeneratedColumn<DateTime>('actual_delivery_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _orderStatusMeta =
      const VerificationMeta('orderStatus');
  @override
  late final GeneratedColumn<String> orderStatus = GeneratedColumn<String>(
      'order_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _deliveryStatusMeta =
      const VerificationMeta('deliveryStatus');
  @override
  late final GeneratedColumn<String> deliveryStatus = GeneratedColumn<String>(
      'delivery_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('not_ordered'));
  static const VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
      'total_amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _paymentStatusMeta =
      const VerificationMeta('paymentStatus');
  @override
  late final GeneratedColumn<String> paymentStatus = GeneratedColumn<String>(
      'payment_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('unpaid'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        itemId,
        supplierId,
        supplierRef,
        itemName,
        itemDescription,
        category,
        sku,
        unitCost,
        supplierName,
        supplierContact,
        supplierEmail,
        supplierPhone,
        quantity,
        minStockLevel,
        maxStockLevel,
        unit,
        warehouseLocation,
        purchaseOrderNumber,
        deliveryOrderNumber,
        purchaseOrderDate,
        expectedDeliveryDate,
        actualDeliveryDate,
        orderStatus,
        deliveryStatus,
        totalAmount,
        paymentStatus,
        createdAt,
        updatedAt,
        createdBy,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'warehouse_items';
  @override
  VerificationContext validateIntegrity(Insertable<WarehouseItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
          _supplierIdMeta,
          supplierId.isAcceptableOrUnknown(
              data['supplier_id']!, _supplierIdMeta));
    }
    if (data.containsKey('supplier_ref')) {
      context.handle(
          _supplierRefMeta,
          supplierRef.isAcceptableOrUnknown(
              data['supplier_ref']!, _supplierRefMeta));
    }
    if (data.containsKey('item_name')) {
      context.handle(_itemNameMeta,
          itemName.isAcceptableOrUnknown(data['item_name']!, _itemNameMeta));
    } else if (isInserting) {
      context.missing(_itemNameMeta);
    }
    if (data.containsKey('item_description')) {
      context.handle(
          _itemDescriptionMeta,
          itemDescription.isAcceptableOrUnknown(
              data['item_description']!, _itemDescriptionMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    }
    if (data.containsKey('unit_cost')) {
      context.handle(_unitCostMeta,
          unitCost.isAcceptableOrUnknown(data['unit_cost']!, _unitCostMeta));
    }
    if (data.containsKey('supplier_name')) {
      context.handle(
          _supplierNameMeta,
          supplierName.isAcceptableOrUnknown(
              data['supplier_name']!, _supplierNameMeta));
    }
    if (data.containsKey('supplier_contact')) {
      context.handle(
          _supplierContactMeta,
          supplierContact.isAcceptableOrUnknown(
              data['supplier_contact']!, _supplierContactMeta));
    }
    if (data.containsKey('supplier_email')) {
      context.handle(
          _supplierEmailMeta,
          supplierEmail.isAcceptableOrUnknown(
              data['supplier_email']!, _supplierEmailMeta));
    }
    if (data.containsKey('supplier_phone')) {
      context.handle(
          _supplierPhoneMeta,
          supplierPhone.isAcceptableOrUnknown(
              data['supplier_phone']!, _supplierPhoneMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('min_stock_level')) {
      context.handle(
          _minStockLevelMeta,
          minStockLevel.isAcceptableOrUnknown(
              data['min_stock_level']!, _minStockLevelMeta));
    }
    if (data.containsKey('max_stock_level')) {
      context.handle(
          _maxStockLevelMeta,
          maxStockLevel.isAcceptableOrUnknown(
              data['max_stock_level']!, _maxStockLevelMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('warehouse_location')) {
      context.handle(
          _warehouseLocationMeta,
          warehouseLocation.isAcceptableOrUnknown(
              data['warehouse_location']!, _warehouseLocationMeta));
    }
    if (data.containsKey('purchase_order_number')) {
      context.handle(
          _purchaseOrderNumberMeta,
          purchaseOrderNumber.isAcceptableOrUnknown(
              data['purchase_order_number']!, _purchaseOrderNumberMeta));
    }
    if (data.containsKey('delivery_order_number')) {
      context.handle(
          _deliveryOrderNumberMeta,
          deliveryOrderNumber.isAcceptableOrUnknown(
              data['delivery_order_number']!, _deliveryOrderNumberMeta));
    }
    if (data.containsKey('purchase_order_date')) {
      context.handle(
          _purchaseOrderDateMeta,
          purchaseOrderDate.isAcceptableOrUnknown(
              data['purchase_order_date']!, _purchaseOrderDateMeta));
    }
    if (data.containsKey('expected_delivery_date')) {
      context.handle(
          _expectedDeliveryDateMeta,
          expectedDeliveryDate.isAcceptableOrUnknown(
              data['expected_delivery_date']!, _expectedDeliveryDateMeta));
    }
    if (data.containsKey('actual_delivery_date')) {
      context.handle(
          _actualDeliveryDateMeta,
          actualDeliveryDate.isAcceptableOrUnknown(
              data['actual_delivery_date']!, _actualDeliveryDateMeta));
    }
    if (data.containsKey('order_status')) {
      context.handle(
          _orderStatusMeta,
          orderStatus.isAcceptableOrUnknown(
              data['order_status']!, _orderStatusMeta));
    }
    if (data.containsKey('delivery_status')) {
      context.handle(
          _deliveryStatusMeta,
          deliveryStatus.isAcceptableOrUnknown(
              data['delivery_status']!, _deliveryStatusMeta));
    }
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount']!, _totalAmountMeta));
    }
    if (data.containsKey('payment_status')) {
      context.handle(
          _paymentStatusMeta,
          paymentStatus.isAcceptableOrUnknown(
              data['payment_status']!, _paymentStatusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WarehouseItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WarehouseItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_id'])!,
      supplierId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}supplier_id']),
      supplierRef: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}supplier_ref']),
      itemName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_name'])!,
      itemDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}item_description']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku']),
      unitCost: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_cost'])!,
      supplierName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}supplier_name']),
      supplierContact: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}supplier_contact']),
      supplierEmail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}supplier_email']),
      supplierPhone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}supplier_phone']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      minStockLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}min_stock_level'])!,
      maxStockLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_stock_level'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      warehouseLocation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}warehouse_location']),
      purchaseOrderNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}purchase_order_number']),
      deliveryOrderNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}delivery_order_number']),
      purchaseOrderDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}purchase_order_date']),
      expectedDeliveryDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}expected_delivery_date']),
      actualDeliveryDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}actual_delivery_date']),
      orderStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_status'])!,
      deliveryStatus: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}delivery_status'])!,
      totalAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_amount'])!,
      paymentStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $WarehouseItemsTable createAlias(String alias) {
    return $WarehouseItemsTable(attachedDatabase, alias);
  }
}

class WarehouseItem extends DataClass implements Insertable<WarehouseItem> {
  final int id;
  final String itemId;
  final String? supplierId;
  final int? supplierRef;
  final String itemName;
  final String? itemDescription;
  final String? category;
  final String? sku;
  final double unitCost;
  final String? supplierName;
  final String? supplierContact;
  final String? supplierEmail;
  final String? supplierPhone;
  final int quantity;
  final int minStockLevel;
  final int maxStockLevel;
  final String unit;
  final String? warehouseLocation;
  final String? purchaseOrderNumber;
  final String? deliveryOrderNumber;
  final DateTime? purchaseOrderDate;
  final DateTime? expectedDeliveryDate;
  final DateTime? actualDeliveryDate;
  final String orderStatus;
  final String deliveryStatus;
  final double totalAmount;
  final String paymentStatus;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? createdBy;
  final String? notes;
  const WarehouseItem(
      {required this.id,
      required this.itemId,
      this.supplierId,
      this.supplierRef,
      required this.itemName,
      this.itemDescription,
      this.category,
      this.sku,
      required this.unitCost,
      this.supplierName,
      this.supplierContact,
      this.supplierEmail,
      this.supplierPhone,
      required this.quantity,
      required this.minStockLevel,
      required this.maxStockLevel,
      required this.unit,
      this.warehouseLocation,
      this.purchaseOrderNumber,
      this.deliveryOrderNumber,
      this.purchaseOrderDate,
      this.expectedDeliveryDate,
      this.actualDeliveryDate,
      required this.orderStatus,
      required this.deliveryStatus,
      required this.totalAmount,
      required this.paymentStatus,
      required this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_id'] = Variable<String>(itemId);
    if (!nullToAbsent || supplierId != null) {
      map['supplier_id'] = Variable<String>(supplierId);
    }
    if (!nullToAbsent || supplierRef != null) {
      map['supplier_ref'] = Variable<int>(supplierRef);
    }
    map['item_name'] = Variable<String>(itemName);
    if (!nullToAbsent || itemDescription != null) {
      map['item_description'] = Variable<String>(itemDescription);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || sku != null) {
      map['sku'] = Variable<String>(sku);
    }
    map['unit_cost'] = Variable<double>(unitCost);
    if (!nullToAbsent || supplierName != null) {
      map['supplier_name'] = Variable<String>(supplierName);
    }
    if (!nullToAbsent || supplierContact != null) {
      map['supplier_contact'] = Variable<String>(supplierContact);
    }
    if (!nullToAbsent || supplierEmail != null) {
      map['supplier_email'] = Variable<String>(supplierEmail);
    }
    if (!nullToAbsent || supplierPhone != null) {
      map['supplier_phone'] = Variable<String>(supplierPhone);
    }
    map['quantity'] = Variable<int>(quantity);
    map['min_stock_level'] = Variable<int>(minStockLevel);
    map['max_stock_level'] = Variable<int>(maxStockLevel);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || warehouseLocation != null) {
      map['warehouse_location'] = Variable<String>(warehouseLocation);
    }
    if (!nullToAbsent || purchaseOrderNumber != null) {
      map['purchase_order_number'] = Variable<String>(purchaseOrderNumber);
    }
    if (!nullToAbsent || deliveryOrderNumber != null) {
      map['delivery_order_number'] = Variable<String>(deliveryOrderNumber);
    }
    if (!nullToAbsent || purchaseOrderDate != null) {
      map['purchase_order_date'] = Variable<DateTime>(purchaseOrderDate);
    }
    if (!nullToAbsent || expectedDeliveryDate != null) {
      map['expected_delivery_date'] = Variable<DateTime>(expectedDeliveryDate);
    }
    if (!nullToAbsent || actualDeliveryDate != null) {
      map['actual_delivery_date'] = Variable<DateTime>(actualDeliveryDate);
    }
    map['order_status'] = Variable<String>(orderStatus);
    map['delivery_status'] = Variable<String>(deliveryStatus);
    map['total_amount'] = Variable<double>(totalAmount);
    map['payment_status'] = Variable<String>(paymentStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  WarehouseItemsCompanion toCompanion(bool nullToAbsent) {
    return WarehouseItemsCompanion(
      id: Value(id),
      itemId: Value(itemId),
      supplierId: supplierId == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierId),
      supplierRef: supplierRef == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierRef),
      itemName: Value(itemName),
      itemDescription: itemDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(itemDescription),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      sku: sku == null && nullToAbsent ? const Value.absent() : Value(sku),
      unitCost: Value(unitCost),
      supplierName: supplierName == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierName),
      supplierContact: supplierContact == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierContact),
      supplierEmail: supplierEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierEmail),
      supplierPhone: supplierPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierPhone),
      quantity: Value(quantity),
      minStockLevel: Value(minStockLevel),
      maxStockLevel: Value(maxStockLevel),
      unit: Value(unit),
      warehouseLocation: warehouseLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(warehouseLocation),
      purchaseOrderNumber: purchaseOrderNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseOrderNumber),
      deliveryOrderNumber: deliveryOrderNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryOrderNumber),
      purchaseOrderDate: purchaseOrderDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseOrderDate),
      expectedDeliveryDate: expectedDeliveryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedDeliveryDate),
      actualDeliveryDate: actualDeliveryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(actualDeliveryDate),
      orderStatus: Value(orderStatus),
      deliveryStatus: Value(deliveryStatus),
      totalAmount: Value(totalAmount),
      paymentStatus: Value(paymentStatus),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory WarehouseItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WarehouseItem(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<String>(json['itemId']),
      supplierId: serializer.fromJson<String?>(json['supplierId']),
      supplierRef: serializer.fromJson<int?>(json['supplierRef']),
      itemName: serializer.fromJson<String>(json['itemName']),
      itemDescription: serializer.fromJson<String?>(json['itemDescription']),
      category: serializer.fromJson<String?>(json['category']),
      sku: serializer.fromJson<String?>(json['sku']),
      unitCost: serializer.fromJson<double>(json['unitCost']),
      supplierName: serializer.fromJson<String?>(json['supplierName']),
      supplierContact: serializer.fromJson<String?>(json['supplierContact']),
      supplierEmail: serializer.fromJson<String?>(json['supplierEmail']),
      supplierPhone: serializer.fromJson<String?>(json['supplierPhone']),
      quantity: serializer.fromJson<int>(json['quantity']),
      minStockLevel: serializer.fromJson<int>(json['minStockLevel']),
      maxStockLevel: serializer.fromJson<int>(json['maxStockLevel']),
      unit: serializer.fromJson<String>(json['unit']),
      warehouseLocation:
          serializer.fromJson<String?>(json['warehouseLocation']),
      purchaseOrderNumber:
          serializer.fromJson<String?>(json['purchaseOrderNumber']),
      deliveryOrderNumber:
          serializer.fromJson<String?>(json['deliveryOrderNumber']),
      purchaseOrderDate:
          serializer.fromJson<DateTime?>(json['purchaseOrderDate']),
      expectedDeliveryDate:
          serializer.fromJson<DateTime?>(json['expectedDeliveryDate']),
      actualDeliveryDate:
          serializer.fromJson<DateTime?>(json['actualDeliveryDate']),
      orderStatus: serializer.fromJson<String>(json['orderStatus']),
      deliveryStatus: serializer.fromJson<String>(json['deliveryStatus']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      paymentStatus: serializer.fromJson<String>(json['paymentStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<String>(itemId),
      'supplierId': serializer.toJson<String?>(supplierId),
      'supplierRef': serializer.toJson<int?>(supplierRef),
      'itemName': serializer.toJson<String>(itemName),
      'itemDescription': serializer.toJson<String?>(itemDescription),
      'category': serializer.toJson<String?>(category),
      'sku': serializer.toJson<String?>(sku),
      'unitCost': serializer.toJson<double>(unitCost),
      'supplierName': serializer.toJson<String?>(supplierName),
      'supplierContact': serializer.toJson<String?>(supplierContact),
      'supplierEmail': serializer.toJson<String?>(supplierEmail),
      'supplierPhone': serializer.toJson<String?>(supplierPhone),
      'quantity': serializer.toJson<int>(quantity),
      'minStockLevel': serializer.toJson<int>(minStockLevel),
      'maxStockLevel': serializer.toJson<int>(maxStockLevel),
      'unit': serializer.toJson<String>(unit),
      'warehouseLocation': serializer.toJson<String?>(warehouseLocation),
      'purchaseOrderNumber': serializer.toJson<String?>(purchaseOrderNumber),
      'deliveryOrderNumber': serializer.toJson<String?>(deliveryOrderNumber),
      'purchaseOrderDate': serializer.toJson<DateTime?>(purchaseOrderDate),
      'expectedDeliveryDate':
          serializer.toJson<DateTime?>(expectedDeliveryDate),
      'actualDeliveryDate': serializer.toJson<DateTime?>(actualDeliveryDate),
      'orderStatus': serializer.toJson<String>(orderStatus),
      'deliveryStatus': serializer.toJson<String>(deliveryStatus),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'paymentStatus': serializer.toJson<String>(paymentStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  WarehouseItem copyWith(
          {int? id,
          String? itemId,
          Value<String?> supplierId = const Value.absent(),
          Value<int?> supplierRef = const Value.absent(),
          String? itemName,
          Value<String?> itemDescription = const Value.absent(),
          Value<String?> category = const Value.absent(),
          Value<String?> sku = const Value.absent(),
          double? unitCost,
          Value<String?> supplierName = const Value.absent(),
          Value<String?> supplierContact = const Value.absent(),
          Value<String?> supplierEmail = const Value.absent(),
          Value<String?> supplierPhone = const Value.absent(),
          int? quantity,
          int? minStockLevel,
          int? maxStockLevel,
          String? unit,
          Value<String?> warehouseLocation = const Value.absent(),
          Value<String?> purchaseOrderNumber = const Value.absent(),
          Value<String?> deliveryOrderNumber = const Value.absent(),
          Value<DateTime?> purchaseOrderDate = const Value.absent(),
          Value<DateTime?> expectedDeliveryDate = const Value.absent(),
          Value<DateTime?> actualDeliveryDate = const Value.absent(),
          String? orderStatus,
          String? deliveryStatus,
          double? totalAmount,
          String? paymentStatus,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<String?> createdBy = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      WarehouseItem(
        id: id ?? this.id,
        itemId: itemId ?? this.itemId,
        supplierId: supplierId.present ? supplierId.value : this.supplierId,
        supplierRef: supplierRef.present ? supplierRef.value : this.supplierRef,
        itemName: itemName ?? this.itemName,
        itemDescription: itemDescription.present
            ? itemDescription.value
            : this.itemDescription,
        category: category.present ? category.value : this.category,
        sku: sku.present ? sku.value : this.sku,
        unitCost: unitCost ?? this.unitCost,
        supplierName:
            supplierName.present ? supplierName.value : this.supplierName,
        supplierContact: supplierContact.present
            ? supplierContact.value
            : this.supplierContact,
        supplierEmail:
            supplierEmail.present ? supplierEmail.value : this.supplierEmail,
        supplierPhone:
            supplierPhone.present ? supplierPhone.value : this.supplierPhone,
        quantity: quantity ?? this.quantity,
        minStockLevel: minStockLevel ?? this.minStockLevel,
        maxStockLevel: maxStockLevel ?? this.maxStockLevel,
        unit: unit ?? this.unit,
        warehouseLocation: warehouseLocation.present
            ? warehouseLocation.value
            : this.warehouseLocation,
        purchaseOrderNumber: purchaseOrderNumber.present
            ? purchaseOrderNumber.value
            : this.purchaseOrderNumber,
        deliveryOrderNumber: deliveryOrderNumber.present
            ? deliveryOrderNumber.value
            : this.deliveryOrderNumber,
        purchaseOrderDate: purchaseOrderDate.present
            ? purchaseOrderDate.value
            : this.purchaseOrderDate,
        expectedDeliveryDate: expectedDeliveryDate.present
            ? expectedDeliveryDate.value
            : this.expectedDeliveryDate,
        actualDeliveryDate: actualDeliveryDate.present
            ? actualDeliveryDate.value
            : this.actualDeliveryDate,
        orderStatus: orderStatus ?? this.orderStatus,
        deliveryStatus: deliveryStatus ?? this.deliveryStatus,
        totalAmount: totalAmount ?? this.totalAmount,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        createdBy: createdBy.present ? createdBy.value : this.createdBy,
        notes: notes.present ? notes.value : this.notes,
      );
  WarehouseItem copyWithCompanion(WarehouseItemsCompanion data) {
    return WarehouseItem(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      supplierId:
          data.supplierId.present ? data.supplierId.value : this.supplierId,
      supplierRef:
          data.supplierRef.present ? data.supplierRef.value : this.supplierRef,
      itemName: data.itemName.present ? data.itemName.value : this.itemName,
      itemDescription: data.itemDescription.present
          ? data.itemDescription.value
          : this.itemDescription,
      category: data.category.present ? data.category.value : this.category,
      sku: data.sku.present ? data.sku.value : this.sku,
      unitCost: data.unitCost.present ? data.unitCost.value : this.unitCost,
      supplierName: data.supplierName.present
          ? data.supplierName.value
          : this.supplierName,
      supplierContact: data.supplierContact.present
          ? data.supplierContact.value
          : this.supplierContact,
      supplierEmail: data.supplierEmail.present
          ? data.supplierEmail.value
          : this.supplierEmail,
      supplierPhone: data.supplierPhone.present
          ? data.supplierPhone.value
          : this.supplierPhone,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      minStockLevel: data.minStockLevel.present
          ? data.minStockLevel.value
          : this.minStockLevel,
      maxStockLevel: data.maxStockLevel.present
          ? data.maxStockLevel.value
          : this.maxStockLevel,
      unit: data.unit.present ? data.unit.value : this.unit,
      warehouseLocation: data.warehouseLocation.present
          ? data.warehouseLocation.value
          : this.warehouseLocation,
      purchaseOrderNumber: data.purchaseOrderNumber.present
          ? data.purchaseOrderNumber.value
          : this.purchaseOrderNumber,
      deliveryOrderNumber: data.deliveryOrderNumber.present
          ? data.deliveryOrderNumber.value
          : this.deliveryOrderNumber,
      purchaseOrderDate: data.purchaseOrderDate.present
          ? data.purchaseOrderDate.value
          : this.purchaseOrderDate,
      expectedDeliveryDate: data.expectedDeliveryDate.present
          ? data.expectedDeliveryDate.value
          : this.expectedDeliveryDate,
      actualDeliveryDate: data.actualDeliveryDate.present
          ? data.actualDeliveryDate.value
          : this.actualDeliveryDate,
      orderStatus:
          data.orderStatus.present ? data.orderStatus.value : this.orderStatus,
      deliveryStatus: data.deliveryStatus.present
          ? data.deliveryStatus.value
          : this.deliveryStatus,
      totalAmount:
          data.totalAmount.present ? data.totalAmount.value : this.totalAmount,
      paymentStatus: data.paymentStatus.present
          ? data.paymentStatus.value
          : this.paymentStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WarehouseItem(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('supplierId: $supplierId, ')
          ..write('supplierRef: $supplierRef, ')
          ..write('itemName: $itemName, ')
          ..write('itemDescription: $itemDescription, ')
          ..write('category: $category, ')
          ..write('sku: $sku, ')
          ..write('unitCost: $unitCost, ')
          ..write('supplierName: $supplierName, ')
          ..write('supplierContact: $supplierContact, ')
          ..write('supplierEmail: $supplierEmail, ')
          ..write('supplierPhone: $supplierPhone, ')
          ..write('quantity: $quantity, ')
          ..write('minStockLevel: $minStockLevel, ')
          ..write('maxStockLevel: $maxStockLevel, ')
          ..write('unit: $unit, ')
          ..write('warehouseLocation: $warehouseLocation, ')
          ..write('purchaseOrderNumber: $purchaseOrderNumber, ')
          ..write('deliveryOrderNumber: $deliveryOrderNumber, ')
          ..write('purchaseOrderDate: $purchaseOrderDate, ')
          ..write('expectedDeliveryDate: $expectedDeliveryDate, ')
          ..write('actualDeliveryDate: $actualDeliveryDate, ')
          ..write('orderStatus: $orderStatus, ')
          ..write('deliveryStatus: $deliveryStatus, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        itemId,
        supplierId,
        supplierRef,
        itemName,
        itemDescription,
        category,
        sku,
        unitCost,
        supplierName,
        supplierContact,
        supplierEmail,
        supplierPhone,
        quantity,
        minStockLevel,
        maxStockLevel,
        unit,
        warehouseLocation,
        purchaseOrderNumber,
        deliveryOrderNumber,
        purchaseOrderDate,
        expectedDeliveryDate,
        actualDeliveryDate,
        orderStatus,
        deliveryStatus,
        totalAmount,
        paymentStatus,
        createdAt,
        updatedAt,
        createdBy,
        notes
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WarehouseItem &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.supplierId == this.supplierId &&
          other.supplierRef == this.supplierRef &&
          other.itemName == this.itemName &&
          other.itemDescription == this.itemDescription &&
          other.category == this.category &&
          other.sku == this.sku &&
          other.unitCost == this.unitCost &&
          other.supplierName == this.supplierName &&
          other.supplierContact == this.supplierContact &&
          other.supplierEmail == this.supplierEmail &&
          other.supplierPhone == this.supplierPhone &&
          other.quantity == this.quantity &&
          other.minStockLevel == this.minStockLevel &&
          other.maxStockLevel == this.maxStockLevel &&
          other.unit == this.unit &&
          other.warehouseLocation == this.warehouseLocation &&
          other.purchaseOrderNumber == this.purchaseOrderNumber &&
          other.deliveryOrderNumber == this.deliveryOrderNumber &&
          other.purchaseOrderDate == this.purchaseOrderDate &&
          other.expectedDeliveryDate == this.expectedDeliveryDate &&
          other.actualDeliveryDate == this.actualDeliveryDate &&
          other.orderStatus == this.orderStatus &&
          other.deliveryStatus == this.deliveryStatus &&
          other.totalAmount == this.totalAmount &&
          other.paymentStatus == this.paymentStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.createdBy == this.createdBy &&
          other.notes == this.notes);
}

class WarehouseItemsCompanion extends UpdateCompanion<WarehouseItem> {
  final Value<int> id;
  final Value<String> itemId;
  final Value<String?> supplierId;
  final Value<int?> supplierRef;
  final Value<String> itemName;
  final Value<String?> itemDescription;
  final Value<String?> category;
  final Value<String?> sku;
  final Value<double> unitCost;
  final Value<String?> supplierName;
  final Value<String?> supplierContact;
  final Value<String?> supplierEmail;
  final Value<String?> supplierPhone;
  final Value<int> quantity;
  final Value<int> minStockLevel;
  final Value<int> maxStockLevel;
  final Value<String> unit;
  final Value<String?> warehouseLocation;
  final Value<String?> purchaseOrderNumber;
  final Value<String?> deliveryOrderNumber;
  final Value<DateTime?> purchaseOrderDate;
  final Value<DateTime?> expectedDeliveryDate;
  final Value<DateTime?> actualDeliveryDate;
  final Value<String> orderStatus;
  final Value<String> deliveryStatus;
  final Value<double> totalAmount;
  final Value<String> paymentStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String?> createdBy;
  final Value<String?> notes;
  const WarehouseItemsCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.supplierRef = const Value.absent(),
    this.itemName = const Value.absent(),
    this.itemDescription = const Value.absent(),
    this.category = const Value.absent(),
    this.sku = const Value.absent(),
    this.unitCost = const Value.absent(),
    this.supplierName = const Value.absent(),
    this.supplierContact = const Value.absent(),
    this.supplierEmail = const Value.absent(),
    this.supplierPhone = const Value.absent(),
    this.quantity = const Value.absent(),
    this.minStockLevel = const Value.absent(),
    this.maxStockLevel = const Value.absent(),
    this.unit = const Value.absent(),
    this.warehouseLocation = const Value.absent(),
    this.purchaseOrderNumber = const Value.absent(),
    this.deliveryOrderNumber = const Value.absent(),
    this.purchaseOrderDate = const Value.absent(),
    this.expectedDeliveryDate = const Value.absent(),
    this.actualDeliveryDate = const Value.absent(),
    this.orderStatus = const Value.absent(),
    this.deliveryStatus = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.notes = const Value.absent(),
  });
  WarehouseItemsCompanion.insert({
    this.id = const Value.absent(),
    required String itemId,
    this.supplierId = const Value.absent(),
    this.supplierRef = const Value.absent(),
    required String itemName,
    this.itemDescription = const Value.absent(),
    this.category = const Value.absent(),
    this.sku = const Value.absent(),
    this.unitCost = const Value.absent(),
    this.supplierName = const Value.absent(),
    this.supplierContact = const Value.absent(),
    this.supplierEmail = const Value.absent(),
    this.supplierPhone = const Value.absent(),
    this.quantity = const Value.absent(),
    this.minStockLevel = const Value.absent(),
    this.maxStockLevel = const Value.absent(),
    this.unit = const Value.absent(),
    this.warehouseLocation = const Value.absent(),
    this.purchaseOrderNumber = const Value.absent(),
    this.deliveryOrderNumber = const Value.absent(),
    this.purchaseOrderDate = const Value.absent(),
    this.expectedDeliveryDate = const Value.absent(),
    this.actualDeliveryDate = const Value.absent(),
    this.orderStatus = const Value.absent(),
    this.deliveryStatus = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.notes = const Value.absent(),
  })  : itemId = Value(itemId),
        itemName = Value(itemName);
  static Insertable<WarehouseItem> custom({
    Expression<int>? id,
    Expression<String>? itemId,
    Expression<String>? supplierId,
    Expression<int>? supplierRef,
    Expression<String>? itemName,
    Expression<String>? itemDescription,
    Expression<String>? category,
    Expression<String>? sku,
    Expression<double>? unitCost,
    Expression<String>? supplierName,
    Expression<String>? supplierContact,
    Expression<String>? supplierEmail,
    Expression<String>? supplierPhone,
    Expression<int>? quantity,
    Expression<int>? minStockLevel,
    Expression<int>? maxStockLevel,
    Expression<String>? unit,
    Expression<String>? warehouseLocation,
    Expression<String>? purchaseOrderNumber,
    Expression<String>? deliveryOrderNumber,
    Expression<DateTime>? purchaseOrderDate,
    Expression<DateTime>? expectedDeliveryDate,
    Expression<DateTime>? actualDeliveryDate,
    Expression<String>? orderStatus,
    Expression<String>? deliveryStatus,
    Expression<double>? totalAmount,
    Expression<String>? paymentStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? createdBy,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (supplierRef != null) 'supplier_ref': supplierRef,
      if (itemName != null) 'item_name': itemName,
      if (itemDescription != null) 'item_description': itemDescription,
      if (category != null) 'category': category,
      if (sku != null) 'sku': sku,
      if (unitCost != null) 'unit_cost': unitCost,
      if (supplierName != null) 'supplier_name': supplierName,
      if (supplierContact != null) 'supplier_contact': supplierContact,
      if (supplierEmail != null) 'supplier_email': supplierEmail,
      if (supplierPhone != null) 'supplier_phone': supplierPhone,
      if (quantity != null) 'quantity': quantity,
      if (minStockLevel != null) 'min_stock_level': minStockLevel,
      if (maxStockLevel != null) 'max_stock_level': maxStockLevel,
      if (unit != null) 'unit': unit,
      if (warehouseLocation != null) 'warehouse_location': warehouseLocation,
      if (purchaseOrderNumber != null)
        'purchase_order_number': purchaseOrderNumber,
      if (deliveryOrderNumber != null)
        'delivery_order_number': deliveryOrderNumber,
      if (purchaseOrderDate != null) 'purchase_order_date': purchaseOrderDate,
      if (expectedDeliveryDate != null)
        'expected_delivery_date': expectedDeliveryDate,
      if (actualDeliveryDate != null)
        'actual_delivery_date': actualDeliveryDate,
      if (orderStatus != null) 'order_status': orderStatus,
      if (deliveryStatus != null) 'delivery_status': deliveryStatus,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdBy != null) 'created_by': createdBy,
      if (notes != null) 'notes': notes,
    });
  }

  WarehouseItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? itemId,
      Value<String?>? supplierId,
      Value<int?>? supplierRef,
      Value<String>? itemName,
      Value<String?>? itemDescription,
      Value<String?>? category,
      Value<String?>? sku,
      Value<double>? unitCost,
      Value<String?>? supplierName,
      Value<String?>? supplierContact,
      Value<String?>? supplierEmail,
      Value<String?>? supplierPhone,
      Value<int>? quantity,
      Value<int>? minStockLevel,
      Value<int>? maxStockLevel,
      Value<String>? unit,
      Value<String?>? warehouseLocation,
      Value<String?>? purchaseOrderNumber,
      Value<String?>? deliveryOrderNumber,
      Value<DateTime?>? purchaseOrderDate,
      Value<DateTime?>? expectedDeliveryDate,
      Value<DateTime?>? actualDeliveryDate,
      Value<String>? orderStatus,
      Value<String>? deliveryStatus,
      Value<double>? totalAmount,
      Value<String>? paymentStatus,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String?>? createdBy,
      Value<String?>? notes}) {
    return WarehouseItemsCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      supplierId: supplierId ?? this.supplierId,
      supplierRef: supplierRef ?? this.supplierRef,
      itemName: itemName ?? this.itemName,
      itemDescription: itemDescription ?? this.itemDescription,
      category: category ?? this.category,
      sku: sku ?? this.sku,
      unitCost: unitCost ?? this.unitCost,
      supplierName: supplierName ?? this.supplierName,
      supplierContact: supplierContact ?? this.supplierContact,
      supplierEmail: supplierEmail ?? this.supplierEmail,
      supplierPhone: supplierPhone ?? this.supplierPhone,
      quantity: quantity ?? this.quantity,
      minStockLevel: minStockLevel ?? this.minStockLevel,
      maxStockLevel: maxStockLevel ?? this.maxStockLevel,
      unit: unit ?? this.unit,
      warehouseLocation: warehouseLocation ?? this.warehouseLocation,
      purchaseOrderNumber: purchaseOrderNumber ?? this.purchaseOrderNumber,
      deliveryOrderNumber: deliveryOrderNumber ?? this.deliveryOrderNumber,
      purchaseOrderDate: purchaseOrderDate ?? this.purchaseOrderDate,
      expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
      actualDeliveryDate: actualDeliveryDate ?? this.actualDeliveryDate,
      orderStatus: orderStatus ?? this.orderStatus,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (supplierRef.present) {
      map['supplier_ref'] = Variable<int>(supplierRef.value);
    }
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    if (itemDescription.present) {
      map['item_description'] = Variable<String>(itemDescription.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (unitCost.present) {
      map['unit_cost'] = Variable<double>(unitCost.value);
    }
    if (supplierName.present) {
      map['supplier_name'] = Variable<String>(supplierName.value);
    }
    if (supplierContact.present) {
      map['supplier_contact'] = Variable<String>(supplierContact.value);
    }
    if (supplierEmail.present) {
      map['supplier_email'] = Variable<String>(supplierEmail.value);
    }
    if (supplierPhone.present) {
      map['supplier_phone'] = Variable<String>(supplierPhone.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (minStockLevel.present) {
      map['min_stock_level'] = Variable<int>(minStockLevel.value);
    }
    if (maxStockLevel.present) {
      map['max_stock_level'] = Variable<int>(maxStockLevel.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (warehouseLocation.present) {
      map['warehouse_location'] = Variable<String>(warehouseLocation.value);
    }
    if (purchaseOrderNumber.present) {
      map['purchase_order_number'] =
          Variable<String>(purchaseOrderNumber.value);
    }
    if (deliveryOrderNumber.present) {
      map['delivery_order_number'] =
          Variable<String>(deliveryOrderNumber.value);
    }
    if (purchaseOrderDate.present) {
      map['purchase_order_date'] = Variable<DateTime>(purchaseOrderDate.value);
    }
    if (expectedDeliveryDate.present) {
      map['expected_delivery_date'] =
          Variable<DateTime>(expectedDeliveryDate.value);
    }
    if (actualDeliveryDate.present) {
      map['actual_delivery_date'] =
          Variable<DateTime>(actualDeliveryDate.value);
    }
    if (orderStatus.present) {
      map['order_status'] = Variable<String>(orderStatus.value);
    }
    if (deliveryStatus.present) {
      map['delivery_status'] = Variable<String>(deliveryStatus.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<String>(paymentStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WarehouseItemsCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('supplierId: $supplierId, ')
          ..write('supplierRef: $supplierRef, ')
          ..write('itemName: $itemName, ')
          ..write('itemDescription: $itemDescription, ')
          ..write('category: $category, ')
          ..write('sku: $sku, ')
          ..write('unitCost: $unitCost, ')
          ..write('supplierName: $supplierName, ')
          ..write('supplierContact: $supplierContact, ')
          ..write('supplierEmail: $supplierEmail, ')
          ..write('supplierPhone: $supplierPhone, ')
          ..write('quantity: $quantity, ')
          ..write('minStockLevel: $minStockLevel, ')
          ..write('maxStockLevel: $maxStockLevel, ')
          ..write('unit: $unit, ')
          ..write('warehouseLocation: $warehouseLocation, ')
          ..write('purchaseOrderNumber: $purchaseOrderNumber, ')
          ..write('deliveryOrderNumber: $deliveryOrderNumber, ')
          ..write('purchaseOrderDate: $purchaseOrderDate, ')
          ..write('expectedDeliveryDate: $expectedDeliveryDate, ')
          ..write('actualDeliveryDate: $actualDeliveryDate, ')
          ..write('orderStatus: $orderStatus, ')
          ..write('deliveryStatus: $deliveryStatus, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _pendingSyncMeta =
      const VerificationMeta('pendingSync');
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
      'pending_sync', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("pending_sync" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, phoneNumber, email, address, createdAt, pendingSync];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(Insertable<Customer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
          _pendingSyncMeta,
          pendingSync.isAcceptableOrUnknown(
              data['pending_sync']!, _pendingSyncMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      pendingSync: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}pending_sync'])!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String name;
  final String? phoneNumber;
  final String? email;
  final String? address;
  final DateTime createdAt;
  final bool pendingSync;
  const Customer(
      {required this.id,
      required this.name,
      this.phoneNumber,
      this.email,
      this.address,
      required this.createdAt,
      required this.pendingSync});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      createdAt: Value(createdAt),
      pendingSync: Value(pendingSync),
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  Customer copyWith(
          {int? id,
          String? name,
          Value<String?> phoneNumber = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> address = const Value.absent(),
          DateTime? createdAt,
          bool? pendingSync}) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
        email: email.present ? email.value : this.email,
        address: address.present ? address.value : this.address,
        createdAt: createdAt ?? this.createdAt,
        pendingSync: pendingSync ?? this.pendingSync,
      );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      pendingSync:
          data.pendingSync.present ? data.pendingSync.value : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, phoneNumber, email, address, createdAt, pendingSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.phoneNumber == this.phoneNumber &&
          other.email == this.email &&
          other.address == this.address &&
          other.createdAt == this.createdAt &&
          other.pendingSync == this.pendingSync);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> phoneNumber;
  final Value<String?> email;
  final Value<String?> address;
  final Value<DateTime> createdAt;
  final Value<bool> pendingSync;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.pendingSync = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.phoneNumber = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.pendingSync = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phoneNumber,
    Expression<String>? email,
    Expression<String>? address,
    Expression<DateTime>? createdAt,
    Expression<bool>? pendingSync,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (createdAt != null) 'created_at': createdAt,
      if (pendingSync != null) 'pending_sync': pendingSync,
    });
  }

  CustomersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? phoneNumber,
      Value<String?>? email,
      Value<String?>? address,
      Value<DateTime>? createdAt,
      Value<bool>? pendingSync}) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }
}

class $VehicleTypeTable extends VehicleType
    with TableInfo<$VehicleTypeTable, VehicleTypeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehicleTypeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _typeNameMeta =
      const VerificationMeta('typeName');
  @override
  late final GeneratedColumn<String> typeName = GeneratedColumn<String>(
      'type_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, typeName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicle_type';
  @override
  VerificationContext validateIntegrity(Insertable<VehicleTypeData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type_name')) {
      context.handle(_typeNameMeta,
          typeName.isAcceptableOrUnknown(data['type_name']!, _typeNameMeta));
    } else if (isInserting) {
      context.missing(_typeNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehicleTypeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehicleTypeData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      typeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type_name'])!,
    );
  }

  @override
  $VehicleTypeTable createAlias(String alias) {
    return $VehicleTypeTable(attachedDatabase, alias);
  }
}

class VehicleTypeData extends DataClass implements Insertable<VehicleTypeData> {
  final int id;
  final String typeName;
  const VehicleTypeData({required this.id, required this.typeName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type_name'] = Variable<String>(typeName);
    return map;
  }

  VehicleTypeCompanion toCompanion(bool nullToAbsent) {
    return VehicleTypeCompanion(
      id: Value(id),
      typeName: Value(typeName),
    );
  }

  factory VehicleTypeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehicleTypeData(
      id: serializer.fromJson<int>(json['id']),
      typeName: serializer.fromJson<String>(json['typeName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'typeName': serializer.toJson<String>(typeName),
    };
  }

  VehicleTypeData copyWith({int? id, String? typeName}) => VehicleTypeData(
        id: id ?? this.id,
        typeName: typeName ?? this.typeName,
      );
  VehicleTypeData copyWithCompanion(VehicleTypeCompanion data) {
    return VehicleTypeData(
      id: data.id.present ? data.id.value : this.id,
      typeName: data.typeName.present ? data.typeName.value : this.typeName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehicleTypeData(')
          ..write('id: $id, ')
          ..write('typeName: $typeName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, typeName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehicleTypeData &&
          other.id == this.id &&
          other.typeName == this.typeName);
}

class VehicleTypeCompanion extends UpdateCompanion<VehicleTypeData> {
  final Value<int> id;
  final Value<String> typeName;
  const VehicleTypeCompanion({
    this.id = const Value.absent(),
    this.typeName = const Value.absent(),
  });
  VehicleTypeCompanion.insert({
    this.id = const Value.absent(),
    required String typeName,
  }) : typeName = Value(typeName);
  static Insertable<VehicleTypeData> custom({
    Expression<int>? id,
    Expression<String>? typeName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (typeName != null) 'type_name': typeName,
    });
  }

  VehicleTypeCompanion copyWith({Value<int>? id, Value<String>? typeName}) {
    return VehicleTypeCompanion(
      id: id ?? this.id,
      typeName: typeName ?? this.typeName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (typeName.present) {
      map['type_name'] = Variable<String>(typeName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehicleTypeCompanion(')
          ..write('id: $id, ')
          ..write('typeName: $typeName')
          ..write(')'))
        .toString();
  }
}

class $VehiclesTable extends Vehicles with TableInfo<$VehiclesTable, Vehicle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _vehicleNumberMeta =
      const VerificationMeta('vehicleNumber');
  @override
  late final GeneratedColumn<String> vehicleNumber = GeneratedColumn<String>(
      'vehicle_number', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _vehicleModelMeta =
      const VerificationMeta('vehicleModel');
  @override
  late final GeneratedColumn<String> vehicleModel = GeneratedColumn<String>(
      'vehicle_model', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES vehicle_type (type_name)'));
  @override
  List<GeneratedColumn> get $columns => [id, vehicleNumber, vehicleModel];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles';
  @override
  VerificationContext validateIntegrity(Insertable<Vehicle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_number')) {
      context.handle(
          _vehicleNumberMeta,
          vehicleNumber.isAcceptableOrUnknown(
              data['vehicle_number']!, _vehicleNumberMeta));
    } else if (isInserting) {
      context.missing(_vehicleNumberMeta);
    }
    if (data.containsKey('vehicle_model')) {
      context.handle(
          _vehicleModelMeta,
          vehicleModel.isAcceptableOrUnknown(
              data['vehicle_model']!, _vehicleModelMeta));
    } else if (isInserting) {
      context.missing(_vehicleModelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vehicle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vehicle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      vehicleNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vehicle_number'])!,
      vehicleModel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vehicle_model'])!,
    );
  }

  @override
  $VehiclesTable createAlias(String alias) {
    return $VehiclesTable(attachedDatabase, alias);
  }
}

class Vehicle extends DataClass implements Insertable<Vehicle> {
  final int id;
  final String vehicleNumber;
  final String vehicleModel;
  const Vehicle(
      {required this.id,
      required this.vehicleNumber,
      required this.vehicleModel});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_number'] = Variable<String>(vehicleNumber);
    map['vehicle_model'] = Variable<String>(vehicleModel);
    return map;
  }

  VehiclesCompanion toCompanion(bool nullToAbsent) {
    return VehiclesCompanion(
      id: Value(id),
      vehicleNumber: Value(vehicleNumber),
      vehicleModel: Value(vehicleModel),
    );
  }

  factory Vehicle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vehicle(
      id: serializer.fromJson<int>(json['id']),
      vehicleNumber: serializer.fromJson<String>(json['vehicleNumber']),
      vehicleModel: serializer.fromJson<String>(json['vehicleModel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleNumber': serializer.toJson<String>(vehicleNumber),
      'vehicleModel': serializer.toJson<String>(vehicleModel),
    };
  }

  Vehicle copyWith({int? id, String? vehicleNumber, String? vehicleModel}) =>
      Vehicle(
        id: id ?? this.id,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber,
        vehicleModel: vehicleModel ?? this.vehicleModel,
      );
  Vehicle copyWithCompanion(VehiclesCompanion data) {
    return Vehicle(
      id: data.id.present ? data.id.value : this.id,
      vehicleNumber: data.vehicleNumber.present
          ? data.vehicleNumber.value
          : this.vehicleNumber,
      vehicleModel: data.vehicleModel.present
          ? data.vehicleModel.value
          : this.vehicleModel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vehicle(')
          ..write('id: $id, ')
          ..write('vehicleNumber: $vehicleNumber, ')
          ..write('vehicleModel: $vehicleModel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, vehicleNumber, vehicleModel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vehicle &&
          other.id == this.id &&
          other.vehicleNumber == this.vehicleNumber &&
          other.vehicleModel == this.vehicleModel);
}

class VehiclesCompanion extends UpdateCompanion<Vehicle> {
  final Value<int> id;
  final Value<String> vehicleNumber;
  final Value<String> vehicleModel;
  const VehiclesCompanion({
    this.id = const Value.absent(),
    this.vehicleNumber = const Value.absent(),
    this.vehicleModel = const Value.absent(),
  });
  VehiclesCompanion.insert({
    this.id = const Value.absent(),
    required String vehicleNumber,
    required String vehicleModel,
  })  : vehicleNumber = Value(vehicleNumber),
        vehicleModel = Value(vehicleModel);
  static Insertable<Vehicle> custom({
    Expression<int>? id,
    Expression<String>? vehicleNumber,
    Expression<String>? vehicleModel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleNumber != null) 'vehicle_number': vehicleNumber,
      if (vehicleModel != null) 'vehicle_model': vehicleModel,
    });
  }

  VehiclesCompanion copyWith(
      {Value<int>? id,
      Value<String>? vehicleNumber,
      Value<String>? vehicleModel}) {
    return VehiclesCompanion(
      id: id ?? this.id,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      vehicleModel: vehicleModel ?? this.vehicleModel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleNumber.present) {
      map['vehicle_number'] = Variable<String>(vehicleNumber.value);
    }
    if (vehicleModel.present) {
      map['vehicle_model'] = Variable<String>(vehicleModel.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesCompanion(')
          ..write('id: $id, ')
          ..write('vehicleNumber: $vehicleNumber, ')
          ..write('vehicleModel: $vehicleModel')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _vehicleNumberMeta =
      const VerificationMeta('vehicleNumber');
  @override
  late final GeneratedColumn<String> vehicleNumber = GeneratedColumn<String>(
      'vehicle_number', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES vehicles (vehicle_number)'));
  static const VerificationMeta _serviceDateTimeMeta =
      const VerificationMeta('serviceDateTime');
  @override
  late final GeneratedColumn<DateTime> serviceDateTime =
      GeneratedColumn<DateTime>('service_date_time', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  static const VerificationMeta _invoiceDateMeta =
      const VerificationMeta('invoiceDate');
  @override
  late final GeneratedColumn<DateTime> invoiceDate = GeneratedColumn<DateTime>(
      'invoice_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
      'total_amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _pendingSyncMeta =
      const VerificationMeta('pendingSync');
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
      'pending_sync', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("pending_sync" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        customerId,
        vehicleNumber,
        serviceDateTime,
        invoiceDate,
        totalAmount,
        pendingSync
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(Insertable<Invoice> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('vehicle_number')) {
      context.handle(
          _vehicleNumberMeta,
          vehicleNumber.isAcceptableOrUnknown(
              data['vehicle_number']!, _vehicleNumberMeta));
    } else if (isInserting) {
      context.missing(_vehicleNumberMeta);
    }
    if (data.containsKey('service_date_time')) {
      context.handle(
          _serviceDateTimeMeta,
          serviceDateTime.isAcceptableOrUnknown(
              data['service_date_time']!, _serviceDateTimeMeta));
    }
    if (data.containsKey('invoice_date')) {
      context.handle(
          _invoiceDateMeta,
          invoiceDate.isAcceptableOrUnknown(
              data['invoice_date']!, _invoiceDateMeta));
    }
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount']!, _totalAmountMeta));
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
          _pendingSyncMeta,
          pendingSync.isAcceptableOrUnknown(
              data['pending_sync']!, _pendingSyncMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}customer_id'])!,
      vehicleNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vehicle_number'])!,
      serviceDateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}service_date_time'])!,
      invoiceDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}invoice_date'])!,
      totalAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_amount'])!,
      pendingSync: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}pending_sync'])!,
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final int id;
  final int customerId;
  final String vehicleNumber;
  final DateTime serviceDateTime;
  final DateTime invoiceDate;
  final double totalAmount;
  final bool pendingSync;
  const Invoice(
      {required this.id,
      required this.customerId,
      required this.vehicleNumber,
      required this.serviceDateTime,
      required this.invoiceDate,
      required this.totalAmount,
      required this.pendingSync});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    map['vehicle_number'] = Variable<String>(vehicleNumber);
    map['service_date_time'] = Variable<DateTime>(serviceDateTime);
    map['invoice_date'] = Variable<DateTime>(invoiceDate);
    map['total_amount'] = Variable<double>(totalAmount);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      customerId: Value(customerId),
      vehicleNumber: Value(vehicleNumber),
      serviceDateTime: Value(serviceDateTime),
      invoiceDate: Value(invoiceDate),
      totalAmount: Value(totalAmount),
      pendingSync: Value(pendingSync),
    );
  }

  factory Invoice.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      vehicleNumber: serializer.fromJson<String>(json['vehicleNumber']),
      serviceDateTime: serializer.fromJson<DateTime>(json['serviceDateTime']),
      invoiceDate: serializer.fromJson<DateTime>(json['invoiceDate']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'vehicleNumber': serializer.toJson<String>(vehicleNumber),
      'serviceDateTime': serializer.toJson<DateTime>(serviceDateTime),
      'invoiceDate': serializer.toJson<DateTime>(invoiceDate),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  Invoice copyWith(
          {int? id,
          int? customerId,
          String? vehicleNumber,
          DateTime? serviceDateTime,
          DateTime? invoiceDate,
          double? totalAmount,
          bool? pendingSync}) =>
      Invoice(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber,
        serviceDateTime: serviceDateTime ?? this.serviceDateTime,
        invoiceDate: invoiceDate ?? this.invoiceDate,
        totalAmount: totalAmount ?? this.totalAmount,
        pendingSync: pendingSync ?? this.pendingSync,
      );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      vehicleNumber: data.vehicleNumber.present
          ? data.vehicleNumber.value
          : this.vehicleNumber,
      serviceDateTime: data.serviceDateTime.present
          ? data.serviceDateTime.value
          : this.serviceDateTime,
      invoiceDate:
          data.invoiceDate.present ? data.invoiceDate.value : this.invoiceDate,
      totalAmount:
          data.totalAmount.present ? data.totalAmount.value : this.totalAmount,
      pendingSync:
          data.pendingSync.present ? data.pendingSync.value : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('vehicleNumber: $vehicleNumber, ')
          ..write('serviceDateTime: $serviceDateTime, ')
          ..write('invoiceDate: $invoiceDate, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, customerId, vehicleNumber,
      serviceDateTime, invoiceDate, totalAmount, pendingSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.vehicleNumber == this.vehicleNumber &&
          other.serviceDateTime == this.serviceDateTime &&
          other.invoiceDate == this.invoiceDate &&
          other.totalAmount == this.totalAmount &&
          other.pendingSync == this.pendingSync);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<String> vehicleNumber;
  final Value<DateTime> serviceDateTime;
  final Value<DateTime> invoiceDate;
  final Value<double> totalAmount;
  final Value<bool> pendingSync;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.vehicleNumber = const Value.absent(),
    this.serviceDateTime = const Value.absent(),
    this.invoiceDate = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.pendingSync = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    required String vehicleNumber,
    this.serviceDateTime = const Value.absent(),
    this.invoiceDate = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.pendingSync = const Value.absent(),
  })  : customerId = Value(customerId),
        vehicleNumber = Value(vehicleNumber);
  static Insertable<Invoice> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<String>? vehicleNumber,
    Expression<DateTime>? serviceDateTime,
    Expression<DateTime>? invoiceDate,
    Expression<double>? totalAmount,
    Expression<bool>? pendingSync,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (vehicleNumber != null) 'vehicle_number': vehicleNumber,
      if (serviceDateTime != null) 'service_date_time': serviceDateTime,
      if (invoiceDate != null) 'invoice_date': invoiceDate,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (pendingSync != null) 'pending_sync': pendingSync,
    });
  }

  InvoicesCompanion copyWith(
      {Value<int>? id,
      Value<int>? customerId,
      Value<String>? vehicleNumber,
      Value<DateTime>? serviceDateTime,
      Value<DateTime>? invoiceDate,
      Value<double>? totalAmount,
      Value<bool>? pendingSync}) {
    return InvoicesCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      serviceDateTime: serviceDateTime ?? this.serviceDateTime,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      totalAmount: totalAmount ?? this.totalAmount,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (vehicleNumber.present) {
      map['vehicle_number'] = Variable<String>(vehicleNumber.value);
    }
    if (serviceDateTime.present) {
      map['service_date_time'] = Variable<DateTime>(serviceDateTime.value);
    }
    if (invoiceDate.present) {
      map['invoice_date'] = Variable<DateTime>(invoiceDate.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('vehicleNumber: $vehicleNumber, ')
          ..write('serviceDateTime: $serviceDateTime, ')
          ..write('invoiceDate: $invoiceDate, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, Supplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _pendingSyncMeta =
      const VerificationMeta('pendingSync');
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
      'pending_sync', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("pending_sync" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, phoneNumber, email, address, createdAt, pendingSync];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(Insertable<Supplier> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
          _pendingSyncMeta,
          pendingSync.isAcceptableOrUnknown(
              data['pending_sync']!, _pendingSyncMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Supplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Supplier(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      pendingSync: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}pending_sync'])!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class Supplier extends DataClass implements Insertable<Supplier> {
  final int id;
  final String name;
  final String? phoneNumber;
  final String? email;
  final String? address;
  final DateTime createdAt;
  final bool pendingSync;
  const Supplier(
      {required this.id,
      required this.name,
      this.phoneNumber,
      this.email,
      this.address,
      required this.createdAt,
      required this.pendingSync});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      name: Value(name),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      createdAt: Value(createdAt),
      pendingSync: Value(pendingSync),
    );
  }

  factory Supplier.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Supplier(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  Supplier copyWith(
          {int? id,
          String? name,
          Value<String?> phoneNumber = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> address = const Value.absent(),
          DateTime? createdAt,
          bool? pendingSync}) =>
      Supplier(
        id: id ?? this.id,
        name: name ?? this.name,
        phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
        email: email.present ? email.value : this.email,
        address: address.present ? address.value : this.address,
        createdAt: createdAt ?? this.createdAt,
        pendingSync: pendingSync ?? this.pendingSync,
      );
  Supplier copyWithCompanion(SuppliersCompanion data) {
    return Supplier(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      pendingSync:
          data.pendingSync.present ? data.pendingSync.value : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Supplier(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, phoneNumber, email, address, createdAt, pendingSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Supplier &&
          other.id == this.id &&
          other.name == this.name &&
          other.phoneNumber == this.phoneNumber &&
          other.email == this.email &&
          other.address == this.address &&
          other.createdAt == this.createdAt &&
          other.pendingSync == this.pendingSync);
}

class SuppliersCompanion extends UpdateCompanion<Supplier> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> phoneNumber;
  final Value<String?> email;
  final Value<String?> address;
  final Value<DateTime> createdAt;
  final Value<bool> pendingSync;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.pendingSync = const Value.absent(),
  });
  SuppliersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.phoneNumber = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.pendingSync = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Supplier> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phoneNumber,
    Expression<String>? email,
    Expression<String>? address,
    Expression<DateTime>? createdAt,
    Expression<bool>? pendingSync,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (createdAt != null) 'created_at': createdAt,
      if (pendingSync != null) 'pending_sync': pendingSync,
    });
  }

  SuppliersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? phoneNumber,
      Value<String?>? email,
      Value<String?>? address,
      Value<DateTime>? createdAt,
      Value<bool>? pendingSync}) {
    return SuppliersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WarehouseItemsTable warehouseItems = $WarehouseItemsTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $VehicleTypeTable vehicleType = $VehicleTypeTable(this);
  late final $VehiclesTable vehicles = $VehiclesTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [warehouseItems, customers, vehicleType, vehicles, invoices, suppliers];
}

typedef $$WarehouseItemsTableCreateCompanionBuilder = WarehouseItemsCompanion
    Function({
  Value<int> id,
  required String itemId,
  Value<String?> supplierId,
  Value<int?> supplierRef,
  required String itemName,
  Value<String?> itemDescription,
  Value<String?> category,
  Value<String?> sku,
  Value<double> unitCost,
  Value<String?> supplierName,
  Value<String?> supplierContact,
  Value<String?> supplierEmail,
  Value<String?> supplierPhone,
  Value<int> quantity,
  Value<int> minStockLevel,
  Value<int> maxStockLevel,
  Value<String> unit,
  Value<String?> warehouseLocation,
  Value<String?> purchaseOrderNumber,
  Value<String?> deliveryOrderNumber,
  Value<DateTime?> purchaseOrderDate,
  Value<DateTime?> expectedDeliveryDate,
  Value<DateTime?> actualDeliveryDate,
  Value<String> orderStatus,
  Value<String> deliveryStatus,
  Value<double> totalAmount,
  Value<String> paymentStatus,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<String?> createdBy,
  Value<String?> notes,
});
typedef $$WarehouseItemsTableUpdateCompanionBuilder = WarehouseItemsCompanion
    Function({
  Value<int> id,
  Value<String> itemId,
  Value<String?> supplierId,
  Value<int?> supplierRef,
  Value<String> itemName,
  Value<String?> itemDescription,
  Value<String?> category,
  Value<String?> sku,
  Value<double> unitCost,
  Value<String?> supplierName,
  Value<String?> supplierContact,
  Value<String?> supplierEmail,
  Value<String?> supplierPhone,
  Value<int> quantity,
  Value<int> minStockLevel,
  Value<int> maxStockLevel,
  Value<String> unit,
  Value<String?> warehouseLocation,
  Value<String?> purchaseOrderNumber,
  Value<String?> deliveryOrderNumber,
  Value<DateTime?> purchaseOrderDate,
  Value<DateTime?> expectedDeliveryDate,
  Value<DateTime?> actualDeliveryDate,
  Value<String> orderStatus,
  Value<String> deliveryStatus,
  Value<double> totalAmount,
  Value<String> paymentStatus,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<String?> createdBy,
  Value<String?> notes,
});

class $$WarehouseItemsTableFilterComposer
    extends Composer<_$AppDatabase, $WarehouseItemsTable> {
  $$WarehouseItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get supplierId => $composableBuilder(
      column: $table.supplierId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get supplierRef => $composableBuilder(
      column: $table.supplierRef, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemName => $composableBuilder(
      column: $table.itemName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemDescription => $composableBuilder(
      column: $table.itemDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get unitCost => $composableBuilder(
      column: $table.unitCost, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get supplierName => $composableBuilder(
      column: $table.supplierName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get supplierContact => $composableBuilder(
      column: $table.supplierContact,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get supplierEmail => $composableBuilder(
      column: $table.supplierEmail, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get supplierPhone => $composableBuilder(
      column: $table.supplierPhone, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minStockLevel => $composableBuilder(
      column: $table.minStockLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxStockLevel => $composableBuilder(
      column: $table.maxStockLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get warehouseLocation => $composableBuilder(
      column: $table.warehouseLocation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get purchaseOrderNumber => $composableBuilder(
      column: $table.purchaseOrderNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deliveryOrderNumber => $composableBuilder(
      column: $table.deliveryOrderNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get purchaseOrderDate => $composableBuilder(
      column: $table.purchaseOrderDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expectedDeliveryDate => $composableBuilder(
      column: $table.expectedDeliveryDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get actualDeliveryDate => $composableBuilder(
      column: $table.actualDeliveryDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderStatus => $composableBuilder(
      column: $table.orderStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deliveryStatus => $composableBuilder(
      column: $table.deliveryStatus,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentStatus => $composableBuilder(
      column: $table.paymentStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$WarehouseItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $WarehouseItemsTable> {
  $$WarehouseItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get supplierId => $composableBuilder(
      column: $table.supplierId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get supplierRef => $composableBuilder(
      column: $table.supplierRef, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemName => $composableBuilder(
      column: $table.itemName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemDescription => $composableBuilder(
      column: $table.itemDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get unitCost => $composableBuilder(
      column: $table.unitCost, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get supplierName => $composableBuilder(
      column: $table.supplierName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get supplierContact => $composableBuilder(
      column: $table.supplierContact,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get supplierEmail => $composableBuilder(
      column: $table.supplierEmail,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get supplierPhone => $composableBuilder(
      column: $table.supplierPhone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minStockLevel => $composableBuilder(
      column: $table.minStockLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxStockLevel => $composableBuilder(
      column: $table.maxStockLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get warehouseLocation => $composableBuilder(
      column: $table.warehouseLocation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get purchaseOrderNumber => $composableBuilder(
      column: $table.purchaseOrderNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deliveryOrderNumber => $composableBuilder(
      column: $table.deliveryOrderNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get purchaseOrderDate => $composableBuilder(
      column: $table.purchaseOrderDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expectedDeliveryDate => $composableBuilder(
      column: $table.expectedDeliveryDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get actualDeliveryDate => $composableBuilder(
      column: $table.actualDeliveryDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderStatus => $composableBuilder(
      column: $table.orderStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deliveryStatus => $composableBuilder(
      column: $table.deliveryStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentStatus => $composableBuilder(
      column: $table.paymentStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$WarehouseItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WarehouseItemsTable> {
  $$WarehouseItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get supplierId => $composableBuilder(
      column: $table.supplierId, builder: (column) => column);

  GeneratedColumn<int> get supplierRef => $composableBuilder(
      column: $table.supplierRef, builder: (column) => column);

  GeneratedColumn<String> get itemName =>
      $composableBuilder(column: $table.itemName, builder: (column) => column);

  GeneratedColumn<String> get itemDescription => $composableBuilder(
      column: $table.itemDescription, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<double> get unitCost =>
      $composableBuilder(column: $table.unitCost, builder: (column) => column);

  GeneratedColumn<String> get supplierName => $composableBuilder(
      column: $table.supplierName, builder: (column) => column);

  GeneratedColumn<String> get supplierContact => $composableBuilder(
      column: $table.supplierContact, builder: (column) => column);

  GeneratedColumn<String> get supplierEmail => $composableBuilder(
      column: $table.supplierEmail, builder: (column) => column);

  GeneratedColumn<String> get supplierPhone => $composableBuilder(
      column: $table.supplierPhone, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get minStockLevel => $composableBuilder(
      column: $table.minStockLevel, builder: (column) => column);

  GeneratedColumn<int> get maxStockLevel => $composableBuilder(
      column: $table.maxStockLevel, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get warehouseLocation => $composableBuilder(
      column: $table.warehouseLocation, builder: (column) => column);

  GeneratedColumn<String> get purchaseOrderNumber => $composableBuilder(
      column: $table.purchaseOrderNumber, builder: (column) => column);

  GeneratedColumn<String> get deliveryOrderNumber => $composableBuilder(
      column: $table.deliveryOrderNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get purchaseOrderDate => $composableBuilder(
      column: $table.purchaseOrderDate, builder: (column) => column);

  GeneratedColumn<DateTime> get expectedDeliveryDate => $composableBuilder(
      column: $table.expectedDeliveryDate, builder: (column) => column);

  GeneratedColumn<DateTime> get actualDeliveryDate => $composableBuilder(
      column: $table.actualDeliveryDate, builder: (column) => column);

  GeneratedColumn<String> get orderStatus => $composableBuilder(
      column: $table.orderStatus, builder: (column) => column);

  GeneratedColumn<String> get deliveryStatus => $composableBuilder(
      column: $table.deliveryStatus, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => column);

  GeneratedColumn<String> get paymentStatus => $composableBuilder(
      column: $table.paymentStatus, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$WarehouseItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WarehouseItemsTable,
    WarehouseItem,
    $$WarehouseItemsTableFilterComposer,
    $$WarehouseItemsTableOrderingComposer,
    $$WarehouseItemsTableAnnotationComposer,
    $$WarehouseItemsTableCreateCompanionBuilder,
    $$WarehouseItemsTableUpdateCompanionBuilder,
    (
      WarehouseItem,
      BaseReferences<_$AppDatabase, $WarehouseItemsTable, WarehouseItem>
    ),
    WarehouseItem,
    PrefetchHooks Function()> {
  $$WarehouseItemsTableTableManager(
      _$AppDatabase db, $WarehouseItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WarehouseItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WarehouseItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WarehouseItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> itemId = const Value.absent(),
            Value<String?> supplierId = const Value.absent(),
            Value<int?> supplierRef = const Value.absent(),
            Value<String> itemName = const Value.absent(),
            Value<String?> itemDescription = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<double> unitCost = const Value.absent(),
            Value<String?> supplierName = const Value.absent(),
            Value<String?> supplierContact = const Value.absent(),
            Value<String?> supplierEmail = const Value.absent(),
            Value<String?> supplierPhone = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<int> minStockLevel = const Value.absent(),
            Value<int> maxStockLevel = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<String?> warehouseLocation = const Value.absent(),
            Value<String?> purchaseOrderNumber = const Value.absent(),
            Value<String?> deliveryOrderNumber = const Value.absent(),
            Value<DateTime?> purchaseOrderDate = const Value.absent(),
            Value<DateTime?> expectedDeliveryDate = const Value.absent(),
            Value<DateTime?> actualDeliveryDate = const Value.absent(),
            Value<String> orderStatus = const Value.absent(),
            Value<String> deliveryStatus = const Value.absent(),
            Value<double> totalAmount = const Value.absent(),
            Value<String> paymentStatus = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              WarehouseItemsCompanion(
            id: id,
            itemId: itemId,
            supplierId: supplierId,
            supplierRef: supplierRef,
            itemName: itemName,
            itemDescription: itemDescription,
            category: category,
            sku: sku,
            unitCost: unitCost,
            supplierName: supplierName,
            supplierContact: supplierContact,
            supplierEmail: supplierEmail,
            supplierPhone: supplierPhone,
            quantity: quantity,
            minStockLevel: minStockLevel,
            maxStockLevel: maxStockLevel,
            unit: unit,
            warehouseLocation: warehouseLocation,
            purchaseOrderNumber: purchaseOrderNumber,
            deliveryOrderNumber: deliveryOrderNumber,
            purchaseOrderDate: purchaseOrderDate,
            expectedDeliveryDate: expectedDeliveryDate,
            actualDeliveryDate: actualDeliveryDate,
            orderStatus: orderStatus,
            deliveryStatus: deliveryStatus,
            totalAmount: totalAmount,
            paymentStatus: paymentStatus,
            createdAt: createdAt,
            updatedAt: updatedAt,
            createdBy: createdBy,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String itemId,
            Value<String?> supplierId = const Value.absent(),
            Value<int?> supplierRef = const Value.absent(),
            required String itemName,
            Value<String?> itemDescription = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String?> sku = const Value.absent(),
            Value<double> unitCost = const Value.absent(),
            Value<String?> supplierName = const Value.absent(),
            Value<String?> supplierContact = const Value.absent(),
            Value<String?> supplierEmail = const Value.absent(),
            Value<String?> supplierPhone = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<int> minStockLevel = const Value.absent(),
            Value<int> maxStockLevel = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<String?> warehouseLocation = const Value.absent(),
            Value<String?> purchaseOrderNumber = const Value.absent(),
            Value<String?> deliveryOrderNumber = const Value.absent(),
            Value<DateTime?> purchaseOrderDate = const Value.absent(),
            Value<DateTime?> expectedDeliveryDate = const Value.absent(),
            Value<DateTime?> actualDeliveryDate = const Value.absent(),
            Value<String> orderStatus = const Value.absent(),
            Value<String> deliveryStatus = const Value.absent(),
            Value<double> totalAmount = const Value.absent(),
            Value<String> paymentStatus = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              WarehouseItemsCompanion.insert(
            id: id,
            itemId: itemId,
            supplierId: supplierId,
            supplierRef: supplierRef,
            itemName: itemName,
            itemDescription: itemDescription,
            category: category,
            sku: sku,
            unitCost: unitCost,
            supplierName: supplierName,
            supplierContact: supplierContact,
            supplierEmail: supplierEmail,
            supplierPhone: supplierPhone,
            quantity: quantity,
            minStockLevel: minStockLevel,
            maxStockLevel: maxStockLevel,
            unit: unit,
            warehouseLocation: warehouseLocation,
            purchaseOrderNumber: purchaseOrderNumber,
            deliveryOrderNumber: deliveryOrderNumber,
            purchaseOrderDate: purchaseOrderDate,
            expectedDeliveryDate: expectedDeliveryDate,
            actualDeliveryDate: actualDeliveryDate,
            orderStatus: orderStatus,
            deliveryStatus: deliveryStatus,
            totalAmount: totalAmount,
            paymentStatus: paymentStatus,
            createdAt: createdAt,
            updatedAt: updatedAt,
            createdBy: createdBy,
            notes: notes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WarehouseItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WarehouseItemsTable,
    WarehouseItem,
    $$WarehouseItemsTableFilterComposer,
    $$WarehouseItemsTableOrderingComposer,
    $$WarehouseItemsTableAnnotationComposer,
    $$WarehouseItemsTableCreateCompanionBuilder,
    $$WarehouseItemsTableUpdateCompanionBuilder,
    (
      WarehouseItem,
      BaseReferences<_$AppDatabase, $WarehouseItemsTable, WarehouseItem>
    ),
    WarehouseItem,
    PrefetchHooks Function()>;
typedef $$CustomersTableCreateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> phoneNumber,
  Value<String?> email,
  Value<String?> address,
  Value<DateTime> createdAt,
  Value<bool> pendingSync,
});
typedef $$CustomersTableUpdateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> phoneNumber,
  Value<String?> email,
  Value<String?> address,
  Value<DateTime> createdAt,
  Value<bool> pendingSync,
});

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.invoices,
          aliasName:
              $_aliasNameGenerator(db.customers.id, db.invoices.customerId));

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager($_db, $_db.invoices)
        .filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get pendingSync => $composableBuilder(
      column: $table.pendingSync, builder: (column) => ColumnFilters(column));

  Expression<bool> invoicesRefs(
      Expression<bool> Function($$InvoicesTableFilterComposer f) f) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.invoices,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoicesTableFilterComposer(
              $db: $db,
              $table: $db.invoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
      column: $table.pendingSync, builder: (column) => ColumnOrderings(column));
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
      column: $table.pendingSync, builder: (column) => column);

  Expression<T> invoicesRefs<T extends Object>(
      Expression<T> Function($$InvoicesTableAnnotationComposer a) f) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.invoices,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoicesTableAnnotationComposer(
              $db: $db,
              $table: $db.invoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CustomersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableAnnotationComposer,
    $$CustomersTableCreateCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder,
    (Customer, $$CustomersTableReferences),
    Customer,
    PrefetchHooks Function({bool invoicesRefs})> {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> phoneNumber = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> pendingSync = const Value.absent(),
          }) =>
              CustomersCompanion(
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            email: email,
            address: address,
            createdAt: createdAt,
            pendingSync: pendingSync,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> phoneNumber = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> pendingSync = const Value.absent(),
          }) =>
              CustomersCompanion.insert(
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            email: email,
            address: address,
            createdAt: createdAt,
            pendingSync: pendingSync,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CustomersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({invoicesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (invoicesRefs) db.invoices],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (invoicesRefs)
                    await $_getPrefetchedData<Customer, $CustomersTable,
                            Invoice>(
                        currentTable: table,
                        referencedTable:
                            $$CustomersTableReferences._invoicesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CustomersTableReferences(db, table, p0)
                                .invoicesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.customerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CustomersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CustomersTable,
    Customer,
    $$CustomersTableFilterComposer,
    $$CustomersTableOrderingComposer,
    $$CustomersTableAnnotationComposer,
    $$CustomersTableCreateCompanionBuilder,
    $$CustomersTableUpdateCompanionBuilder,
    (Customer, $$CustomersTableReferences),
    Customer,
    PrefetchHooks Function({bool invoicesRefs})>;
typedef $$VehicleTypeTableCreateCompanionBuilder = VehicleTypeCompanion
    Function({
  Value<int> id,
  required String typeName,
});
typedef $$VehicleTypeTableUpdateCompanionBuilder = VehicleTypeCompanion
    Function({
  Value<int> id,
  Value<String> typeName,
});

final class $$VehicleTypeTableReferences
    extends BaseReferences<_$AppDatabase, $VehicleTypeTable, VehicleTypeData> {
  $$VehicleTypeTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VehiclesTable, List<Vehicle>> _vehiclesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.vehicles,
          aliasName: $_aliasNameGenerator(
              db.vehicleType.typeName, db.vehicles.vehicleModel));

  $$VehiclesTableProcessedTableManager get vehiclesRefs {
    final manager = $$VehiclesTableTableManager($_db, $_db.vehicles).filter(
        (f) => f.vehicleModel.typeName
            .sqlEquals($_itemColumn<String>('type_name')!));

    final cache = $_typedResult.readTableOrNull(_vehiclesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$VehicleTypeTableFilterComposer
    extends Composer<_$AppDatabase, $VehicleTypeTable> {
  $$VehicleTypeTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get typeName => $composableBuilder(
      column: $table.typeName, builder: (column) => ColumnFilters(column));

  Expression<bool> vehiclesRefs(
      Expression<bool> Function($$VehiclesTableFilterComposer f) f) {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.typeName,
        referencedTable: $db.vehicles,
        getReferencedColumn: (t) => t.vehicleModel,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehiclesTableFilterComposer(
              $db: $db,
              $table: $db.vehicles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VehicleTypeTableOrderingComposer
    extends Composer<_$AppDatabase, $VehicleTypeTable> {
  $$VehicleTypeTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get typeName => $composableBuilder(
      column: $table.typeName, builder: (column) => ColumnOrderings(column));
}

class $$VehicleTypeTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehicleTypeTable> {
  $$VehicleTypeTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get typeName =>
      $composableBuilder(column: $table.typeName, builder: (column) => column);

  Expression<T> vehiclesRefs<T extends Object>(
      Expression<T> Function($$VehiclesTableAnnotationComposer a) f) {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.typeName,
        referencedTable: $db.vehicles,
        getReferencedColumn: (t) => t.vehicleModel,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehiclesTableAnnotationComposer(
              $db: $db,
              $table: $db.vehicles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VehicleTypeTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VehicleTypeTable,
    VehicleTypeData,
    $$VehicleTypeTableFilterComposer,
    $$VehicleTypeTableOrderingComposer,
    $$VehicleTypeTableAnnotationComposer,
    $$VehicleTypeTableCreateCompanionBuilder,
    $$VehicleTypeTableUpdateCompanionBuilder,
    (VehicleTypeData, $$VehicleTypeTableReferences),
    VehicleTypeData,
    PrefetchHooks Function({bool vehiclesRefs})> {
  $$VehicleTypeTableTableManager(_$AppDatabase db, $VehicleTypeTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehicleTypeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehicleTypeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehicleTypeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> typeName = const Value.absent(),
          }) =>
              VehicleTypeCompanion(
            id: id,
            typeName: typeName,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String typeName,
          }) =>
              VehicleTypeCompanion.insert(
            id: id,
            typeName: typeName,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$VehicleTypeTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({vehiclesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (vehiclesRefs) db.vehicles],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (vehiclesRefs)
                    await $_getPrefetchedData<VehicleTypeData,
                            $VehicleTypeTable, Vehicle>(
                        currentTable: table,
                        referencedTable:
                            $$VehicleTypeTableReferences._vehiclesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$VehicleTypeTableReferences(db, table, p0)
                                .vehiclesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.vehicleModel == item.typeName),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$VehicleTypeTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VehicleTypeTable,
    VehicleTypeData,
    $$VehicleTypeTableFilterComposer,
    $$VehicleTypeTableOrderingComposer,
    $$VehicleTypeTableAnnotationComposer,
    $$VehicleTypeTableCreateCompanionBuilder,
    $$VehicleTypeTableUpdateCompanionBuilder,
    (VehicleTypeData, $$VehicleTypeTableReferences),
    VehicleTypeData,
    PrefetchHooks Function({bool vehiclesRefs})>;
typedef $$VehiclesTableCreateCompanionBuilder = VehiclesCompanion Function({
  Value<int> id,
  required String vehicleNumber,
  required String vehicleModel,
});
typedef $$VehiclesTableUpdateCompanionBuilder = VehiclesCompanion Function({
  Value<int> id,
  Value<String> vehicleNumber,
  Value<String> vehicleModel,
});

final class $$VehiclesTableReferences
    extends BaseReferences<_$AppDatabase, $VehiclesTable, Vehicle> {
  $$VehiclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehicleTypeTable _vehicleModelTable(_$AppDatabase db) =>
      db.vehicleType.createAlias($_aliasNameGenerator(
          db.vehicles.vehicleModel, db.vehicleType.typeName));

  $$VehicleTypeTableProcessedTableManager get vehicleModel {
    final $_column = $_itemColumn<String>('vehicle_model')!;

    final manager = $$VehicleTypeTableTableManager($_db, $_db.vehicleType)
        .filter((f) => f.typeName.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleModelTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.invoices,
          aliasName: $_aliasNameGenerator(
              db.vehicles.vehicleNumber, db.invoices.vehicleNumber));

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager($_db, $_db.invoices).filter(
        (f) => f.vehicleNumber.vehicleNumber
            .sqlEquals($_itemColumn<String>('vehicle_number')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$VehiclesTableFilterComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get vehicleNumber => $composableBuilder(
      column: $table.vehicleNumber, builder: (column) => ColumnFilters(column));

  $$VehicleTypeTableFilterComposer get vehicleModel {
    final $$VehicleTypeTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vehicleModel,
        referencedTable: $db.vehicleType,
        getReferencedColumn: (t) => t.typeName,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehicleTypeTableFilterComposer(
              $db: $db,
              $table: $db.vehicleType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> invoicesRefs(
      Expression<bool> Function($$InvoicesTableFilterComposer f) f) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vehicleNumber,
        referencedTable: $db.invoices,
        getReferencedColumn: (t) => t.vehicleNumber,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoicesTableFilterComposer(
              $db: $db,
              $table: $db.invoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VehiclesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get vehicleNumber => $composableBuilder(
      column: $table.vehicleNumber,
      builder: (column) => ColumnOrderings(column));

  $$VehicleTypeTableOrderingComposer get vehicleModel {
    final $$VehicleTypeTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vehicleModel,
        referencedTable: $db.vehicleType,
        getReferencedColumn: (t) => t.typeName,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehicleTypeTableOrderingComposer(
              $db: $db,
              $table: $db.vehicleType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VehiclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get vehicleNumber => $composableBuilder(
      column: $table.vehicleNumber, builder: (column) => column);

  $$VehicleTypeTableAnnotationComposer get vehicleModel {
    final $$VehicleTypeTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vehicleModel,
        referencedTable: $db.vehicleType,
        getReferencedColumn: (t) => t.typeName,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehicleTypeTableAnnotationComposer(
              $db: $db,
              $table: $db.vehicleType,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> invoicesRefs<T extends Object>(
      Expression<T> Function($$InvoicesTableAnnotationComposer a) f) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vehicleNumber,
        referencedTable: $db.invoices,
        getReferencedColumn: (t) => t.vehicleNumber,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoicesTableAnnotationComposer(
              $db: $db,
              $table: $db.invoices,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VehiclesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VehiclesTable,
    Vehicle,
    $$VehiclesTableFilterComposer,
    $$VehiclesTableOrderingComposer,
    $$VehiclesTableAnnotationComposer,
    $$VehiclesTableCreateCompanionBuilder,
    $$VehiclesTableUpdateCompanionBuilder,
    (Vehicle, $$VehiclesTableReferences),
    Vehicle,
    PrefetchHooks Function({bool vehicleModel, bool invoicesRefs})> {
  $$VehiclesTableTableManager(_$AppDatabase db, $VehiclesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> vehicleNumber = const Value.absent(),
            Value<String> vehicleModel = const Value.absent(),
          }) =>
              VehiclesCompanion(
            id: id,
            vehicleNumber: vehicleNumber,
            vehicleModel: vehicleModel,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String vehicleNumber,
            required String vehicleModel,
          }) =>
              VehiclesCompanion.insert(
            id: id,
            vehicleNumber: vehicleNumber,
            vehicleModel: vehicleModel,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$VehiclesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {vehicleModel = false, invoicesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (invoicesRefs) db.invoices],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (vehicleModel) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.vehicleModel,
                    referencedTable:
                        $$VehiclesTableReferences._vehicleModelTable(db),
                    referencedColumn: $$VehiclesTableReferences
                        ._vehicleModelTable(db)
                        .typeName,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (invoicesRefs)
                    await $_getPrefetchedData<Vehicle, $VehiclesTable, Invoice>(
                        currentTable: table,
                        referencedTable:
                            $$VehiclesTableReferences._invoicesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$VehiclesTableReferences(db, table, p0)
                                .invoicesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.vehicleNumber == item.vehicleNumber),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$VehiclesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VehiclesTable,
    Vehicle,
    $$VehiclesTableFilterComposer,
    $$VehiclesTableOrderingComposer,
    $$VehiclesTableAnnotationComposer,
    $$VehiclesTableCreateCompanionBuilder,
    $$VehiclesTableUpdateCompanionBuilder,
    (Vehicle, $$VehiclesTableReferences),
    Vehicle,
    PrefetchHooks Function({bool vehicleModel, bool invoicesRefs})>;
typedef $$InvoicesTableCreateCompanionBuilder = InvoicesCompanion Function({
  Value<int> id,
  required int customerId,
  required String vehicleNumber,
  Value<DateTime> serviceDateTime,
  Value<DateTime> invoiceDate,
  Value<double> totalAmount,
  Value<bool> pendingSync,
});
typedef $$InvoicesTableUpdateCompanionBuilder = InvoicesCompanion Function({
  Value<int> id,
  Value<int> customerId,
  Value<String> vehicleNumber,
  Value<DateTime> serviceDateTime,
  Value<DateTime> invoiceDate,
  Value<double> totalAmount,
  Value<bool> pendingSync,
});

final class $$InvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoicesTable, Invoice> {
  $$InvoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
          $_aliasNameGenerator(db.invoices.customerId, db.customers.id));

  $$CustomersTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<int>('customer_id')!;

    final manager = $$CustomersTableTableManager($_db, $_db.customers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $VehiclesTable _vehicleNumberTable(_$AppDatabase db) =>
      db.vehicles.createAlias($_aliasNameGenerator(
          db.invoices.vehicleNumber, db.vehicles.vehicleNumber));

  $$VehiclesTableProcessedTableManager get vehicleNumber {
    final $_column = $_itemColumn<String>('vehicle_number')!;

    final manager = $$VehiclesTableTableManager($_db, $_db.vehicles)
        .filter((f) => f.vehicleNumber.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleNumberTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get serviceDateTime => $composableBuilder(
      column: $table.serviceDateTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get invoiceDate => $composableBuilder(
      column: $table.invoiceDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get pendingSync => $composableBuilder(
      column: $table.pendingSync, builder: (column) => ColumnFilters(column));

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableFilterComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$VehiclesTableFilterComposer get vehicleNumber {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vehicleNumber,
        referencedTable: $db.vehicles,
        getReferencedColumn: (t) => t.vehicleNumber,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehiclesTableFilterComposer(
              $db: $db,
              $table: $db.vehicles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get serviceDateTime => $composableBuilder(
      column: $table.serviceDateTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get invoiceDate => $composableBuilder(
      column: $table.invoiceDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
      column: $table.pendingSync, builder: (column) => ColumnOrderings(column));

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableOrderingComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$VehiclesTableOrderingComposer get vehicleNumber {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vehicleNumber,
        referencedTable: $db.vehicles,
        getReferencedColumn: (t) => t.vehicleNumber,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehiclesTableOrderingComposer(
              $db: $db,
              $table: $db.vehicles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get serviceDateTime => $composableBuilder(
      column: $table.serviceDateTime, builder: (column) => column);

  GeneratedColumn<DateTime> get invoiceDate => $composableBuilder(
      column: $table.invoiceDate, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
      column: $table.pendingSync, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.customers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomersTableAnnotationComposer(
              $db: $db,
              $table: $db.customers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$VehiclesTableAnnotationComposer get vehicleNumber {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vehicleNumber,
        referencedTable: $db.vehicles,
        getReferencedColumn: (t) => t.vehicleNumber,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehiclesTableAnnotationComposer(
              $db: $db,
              $table: $db.vehicles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InvoicesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InvoicesTable,
    Invoice,
    $$InvoicesTableFilterComposer,
    $$InvoicesTableOrderingComposer,
    $$InvoicesTableAnnotationComposer,
    $$InvoicesTableCreateCompanionBuilder,
    $$InvoicesTableUpdateCompanionBuilder,
    (Invoice, $$InvoicesTableReferences),
    Invoice,
    PrefetchHooks Function({bool customerId, bool vehicleNumber})> {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> customerId = const Value.absent(),
            Value<String> vehicleNumber = const Value.absent(),
            Value<DateTime> serviceDateTime = const Value.absent(),
            Value<DateTime> invoiceDate = const Value.absent(),
            Value<double> totalAmount = const Value.absent(),
            Value<bool> pendingSync = const Value.absent(),
          }) =>
              InvoicesCompanion(
            id: id,
            customerId: customerId,
            vehicleNumber: vehicleNumber,
            serviceDateTime: serviceDateTime,
            invoiceDate: invoiceDate,
            totalAmount: totalAmount,
            pendingSync: pendingSync,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int customerId,
            required String vehicleNumber,
            Value<DateTime> serviceDateTime = const Value.absent(),
            Value<DateTime> invoiceDate = const Value.absent(),
            Value<double> totalAmount = const Value.absent(),
            Value<bool> pendingSync = const Value.absent(),
          }) =>
              InvoicesCompanion.insert(
            id: id,
            customerId: customerId,
            vehicleNumber: vehicleNumber,
            serviceDateTime: serviceDateTime,
            invoiceDate: invoiceDate,
            totalAmount: totalAmount,
            pendingSync: pendingSync,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$InvoicesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({customerId = false, vehicleNumber = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (customerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.customerId,
                    referencedTable:
                        $$InvoicesTableReferences._customerIdTable(db),
                    referencedColumn:
                        $$InvoicesTableReferences._customerIdTable(db).id,
                  ) as T;
                }
                if (vehicleNumber) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.vehicleNumber,
                    referencedTable:
                        $$InvoicesTableReferences._vehicleNumberTable(db),
                    referencedColumn: $$InvoicesTableReferences
                        ._vehicleNumberTable(db)
                        .vehicleNumber,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$InvoicesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $InvoicesTable,
    Invoice,
    $$InvoicesTableFilterComposer,
    $$InvoicesTableOrderingComposer,
    $$InvoicesTableAnnotationComposer,
    $$InvoicesTableCreateCompanionBuilder,
    $$InvoicesTableUpdateCompanionBuilder,
    (Invoice, $$InvoicesTableReferences),
    Invoice,
    PrefetchHooks Function({bool customerId, bool vehicleNumber})>;
typedef $$SuppliersTableCreateCompanionBuilder = SuppliersCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> phoneNumber,
  Value<String?> email,
  Value<String?> address,
  Value<DateTime> createdAt,
  Value<bool> pendingSync,
});
typedef $$SuppliersTableUpdateCompanionBuilder = SuppliersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> phoneNumber,
  Value<String?> email,
  Value<String?> address,
  Value<DateTime> createdAt,
  Value<bool> pendingSync,
});

class $$SuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get pendingSync => $composableBuilder(
      column: $table.pendingSync, builder: (column) => ColumnFilters(column));
}

class $$SuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
      column: $table.pendingSync, builder: (column) => ColumnOrderings(column));
}

class $$SuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
      column: $table.pendingSync, builder: (column) => column);
}

class $$SuppliersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SuppliersTable,
    Supplier,
    $$SuppliersTableFilterComposer,
    $$SuppliersTableOrderingComposer,
    $$SuppliersTableAnnotationComposer,
    $$SuppliersTableCreateCompanionBuilder,
    $$SuppliersTableUpdateCompanionBuilder,
    (Supplier, BaseReferences<_$AppDatabase, $SuppliersTable, Supplier>),
    Supplier,
    PrefetchHooks Function()> {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> phoneNumber = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> pendingSync = const Value.absent(),
          }) =>
              SuppliersCompanion(
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            email: email,
            address: address,
            createdAt: createdAt,
            pendingSync: pendingSync,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> phoneNumber = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> pendingSync = const Value.absent(),
          }) =>
              SuppliersCompanion.insert(
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            email: email,
            address: address,
            createdAt: createdAt,
            pendingSync: pendingSync,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SuppliersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SuppliersTable,
    Supplier,
    $$SuppliersTableFilterComposer,
    $$SuppliersTableOrderingComposer,
    $$SuppliersTableAnnotationComposer,
    $$SuppliersTableCreateCompanionBuilder,
    $$SuppliersTableUpdateCompanionBuilder,
    (Supplier, BaseReferences<_$AppDatabase, $SuppliersTable, Supplier>),
    Supplier,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WarehouseItemsTableTableManager get warehouseItems =>
      $$WarehouseItemsTableTableManager(_db, _db.warehouseItems);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$VehicleTypeTableTableManager get vehicleType =>
      $$VehicleTypeTableTableManager(_db, _db.vehicleType);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db, _db.vehicles);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db, _db.suppliers);
}
