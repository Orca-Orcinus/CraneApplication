import 'package:craneapplication/features/auth/firebasestore.dart';
import 'package:uuid/uuid.dart';

class SupplierProfile{
  String supplierId;
  String supplierName;
  String? supplierEmail;
  String? supplierPhoneNumber;

  DateTime? createdAt;
  DateTime? updatedAt;
  String createdBy;
  String? updatedBy;

  SupplierProfile({
    String? supplierId,
    required this.supplierName,
    this.supplierEmail,
    this.supplierPhoneNumber,
    this.createdAt,
    this.updatedAt,
    required this.createdBy,
    this.updatedBy,
  }) : supplierId = supplierId ?? Uuid().v4();

  Map<String,dynamic> toJson(){
    return {
      'supplierId': supplierId,
      'supplierName': supplierName,
      'supplierEmail': supplierEmail,
      'supplierPhoneNumber': supplierPhoneNumber,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'createdBy': createdBy,
      'updatedBy': updatedBy,
    };
  }

  factory SupplierProfile.fromJson(Map<String, dynamic> json) {
    return SupplierProfile(
      supplierId: json['supplierId'],
      supplierName: json['supplierName'],
      supplierEmail: json['supplierEmail'],
      supplierPhoneNumber: json['supplierPhoneNumber'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
    );
  }
}

class SupplierDatabaseControl {
  final FireStoreService _fireStoreService = FireStoreService();

  static const String collectionName = "suppliers";

  Future<void> addSupplier(SupplierProfile supplier) async {
    await _fireStoreService.addData(collection: collectionName, data:supplier.toJson(),
    );
  }

  Future<void> updateSupplier(SupplierProfile supplier) async {
    await _fireStoreService.updateData(
      collection: collectionName,
      documentId: supplier.supplierId,
      data: supplier.toJson(),
    );
  }

  Future<void> deleteSupplier(String supplierId) async {
    await _fireStoreService.deleteData(
      collection: collectionName,
      documentId: supplierId,
    );
  } 

  Future<SupplierProfile?> getSupplierById(String supplierId) async {
    final data = await _fireStoreService.getSpecificData(
      collection: collectionName,
      id: supplierId,
    );

    if (data != null) {
      return SupplierProfile.fromJson(data);
    }
    return null;
  }

  Future<List<SupplierProfile>> getAllSuppliers() async {
    final dataList = await _fireStoreService.streamCollection(collectionName)?.first;

      if(dataList != null)
      {
        List<SupplierProfile> suppliers = (dataList['docs'] as List)
            .map((doc) => SupplierProfile.fromJson(doc))
            .toList();
        return suppliers;
      }
      return [];
  }

  Future<Map<String, dynamic>?> getSupplierByName(String supplierName) async {
    return await _fireStoreService.getDataBy(
      collection: collectionName,
      contextName: "supplierName",
      contextValue: supplierName,
    );
  }
}