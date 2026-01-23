class DeliveryOrder {  
  final String companyName = "STANDARD BUILDING MATERIALS SDN. BHD.";
  final String companyAddress ="LOT 2988 BERJAYA INDUSTRIAL PARK, JOHOR";
  final String companyPhone = "013-5732686";
  final String companyEmail = "standardbuildingmaterial@gmail.com";
  final String doNumber;
  final DateTime date;
  final String customerName;
  final String customerContact;
  final String deliveryAddress;
  final String terms;
  final String currency = "RM";
  final String agentName;
  final String agentPhone;
  final List<DeliveryOrderItems> items;

  DeliveryOrder({
    required this.doNumber,
    required this.date,
    required this.customerName,
    required this.customerContact,
    required this.deliveryAddress,
    required this.terms,
    required this.agentName,
    required this.agentPhone,    
    required this.items,
  });  

  double get totalQty => items.fold(0, (sum, item) => sum + item.quantity);

  void addItem({
    required String description,
    required String uom,
    required double quantity,
  }) {
    final itemNumber = items.length + 1;
    items.add(DeliveryOrderItems(
      itemNumber: itemNumber,
      description: description,
      uom: uom,
      quantity: quantity,
    ));
  }
}

class DeliveryOrderItems
{
  final int itemNumber;
  final String description;
  final String uom;
  final double quantity;

  DeliveryOrderItems({
    required this.itemNumber,
    required this.description,
    required this.uom,
    required this.quantity,
  });
}