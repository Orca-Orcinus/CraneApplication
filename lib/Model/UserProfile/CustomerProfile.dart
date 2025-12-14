import 'package:craneapplication/features/auth/firebasestore.dart';
import 'package:uuid/uuid.dart';

class CustomerProfile{
  String customerId;
  String customerName;
  String? customerEmail;
  String? customerPhoneNumber;

  DateTime? createdAt;
  DateTime? updatedAt;
  String createdBy;
  String? updatedBy;

  CustomerProfile({
    String? customerId,
    required this.customerName,
    this.customerEmail,
    this.customerPhoneNumber,
    this.createdAt,
    this.updatedAt,
    required this.createdBy,
    this.updatedBy,
  }) : customerId = customerId ?? Uuid().v4();

  Map<String,dynamic> toJson(){
    return {
      'supplierId': customerId,
      'supplierName': customerName,
      'supplierEmail': customerEmail,
      'supplierPhoneNumber': customerPhoneNumber,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'createdBy': createdBy,
      'updatedBy': updatedBy,
    };
  }

  factory CustomerProfile.fromJson(Map<String, dynamic> json) {
    return CustomerProfile(
      customerId: json['customerId'],
      customerName: json['customerName'],
      customerEmail: json['customerEmail'],
      customerPhoneNumber: json['customerPhoneNumber'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
    );
  }
}

class CustomerDatabaseControl {
  final FireStoreService _fireStoreService = FireStoreService();

  static const String collectionName = "customers";

  Future<void> addCustomer(CustomerProfile customer) async {
    await _fireStoreService.addData(collection: collectionName, data:customer.toJson(),
    );
  }

  Future<void> updateCustomer(CustomerProfile customer) async {
    await _fireStoreService.updateData(
      collection: collectionName,
      documentId: customer.customerId,
      data: customer.toJson(),
    );
  }

  Future<void> deleteCustomer(CustomerProfile customer) async {
    await _fireStoreService.deleteData(
      collection: collectionName,
      documentId: customer.customerId,
    );
  }

  Future<void> deleteCustomerById(String customerId) async {
    await _fireStoreService.deleteData(
      collection: collectionName,
      documentId: customerId,
    );
  }

  Future<List<CustomerProfile>> fetchAllCustomers() async {
    try{
      final snapshot = await _fireStoreService.streamCollection(collectionName)?.first;
      if(snapshot != null)
      {
        List<CustomerProfile> customers = (snapshot['docs'] as List)
            .map((doc) => CustomerProfile.fromJson(doc))
            .toList();
        return customers;
      }
      return [];
    }
    catch(e)
    {
      print('Error fetching customers: $e');
      rethrow;
    }
  }

  Future<Map<String,dynamic>?> getCustomerById(String customerName) async {
    return await _fireStoreService.getDataBy(
      collection: collectionName,
      contextName: "customerName",
      contextValue: customerName,
    );
  }
}