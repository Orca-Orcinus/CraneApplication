

class StockReceivedModel {
  String itemCode;
  String itemDescription;
  String unitOfMeasurement;
  double quantityReceived;
  String? location;
  String? project;
  double subTotal;

  StockReceivedModel({
    required this.itemCode,
    required this.itemDescription,
    required this.unitOfMeasurement,
    required this.quantityReceived,
    this.location,
    this.project,
    required this.subTotal,
  });

  Map<String,dynamic> toJson(){
    return {
      'itemCode': itemCode,
      'itemDescription': itemDescription,
      'unitOfMeasurement': unitOfMeasurement,
      'quantityReceived': quantityReceived,
      'location': location,
      'project': project,
      'subTotal': subTotal,
    };
  }

  factory StockReceivedModel.fromJson(Map<String, dynamic> json) {
    return StockReceivedModel(
      itemCode: json['itemCode'],
      itemDescription: json['itemDescription'],
      unitOfMeasurement: json['unitOfMeasurement'],
      quantityReceived: json['quantityReceived'],
      location: json['location'],
      project: json['project'],
      subTotal: json['subTotal'],
    );
  }
}