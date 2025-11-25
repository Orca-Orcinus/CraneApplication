class SupplierEntity{
  final int? id;
  final String name;
  final String? phoneNumber;
  final String? email;
  final String? address;  

  SupplierEntity({
    this.id,
    required this.name,
    this.phoneNumber,
    this.email,
    this.address,    
  });

  SupplierEntity copyWith({
    int? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? address,    
  }) {
    return SupplierEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,      
    );
  }
}