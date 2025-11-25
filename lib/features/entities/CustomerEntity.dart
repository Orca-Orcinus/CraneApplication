class CustomerEntity 
{
  final int? id;
  final String name;
  final String? phoneNumber;
  final String? emailAddress;
  final String? address;

  CustomerEntity({
    this.id,
    required this.name,
    this.phoneNumber,
    this.emailAddress,
    this.address,
  });

  CustomerEntity copyWith({
    int? id,
    String? name,
    String? phoneNumber,
    String? emailAddress,
    String? address,
  }) {
    return CustomerEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      address: address ?? this.address,
    );
  }
}