

class StockTransferModel{
  String itemCode;
  String itemDescription;
  String fromLocation;
  String toLocation;
  String unitOfMeasurement;
  double quantityTransferred;

  StockTransferModel({
    required this.itemCode,
    required this.itemDescription,
    required this.fromLocation,
    required this.toLocation,
    required this.unitOfMeasurement,
    required this.quantityTransferred,
  });

  Map<String,dynamic> toJson(){
    return {
      'itemCode': itemCode,
      'itemDescription': itemDescription,
      'fromLocation': fromLocation,
      'toLocation': toLocation,
      'unitOfMeasurement': unitOfMeasurement,
      'quantityTransferred': quantityTransferred,
    };
  }

  factory StockTransferModel.fromJson(Map<String, dynamic> json) {
    return StockTransferModel(
      itemCode: json['itemCode'],
      itemDescription: json['itemDescription'],
      fromLocation: json['fromLocation'],
      toLocation: json['toLocation'],
      unitOfMeasurement: json['unitOfMeasurement'],
      quantityTransferred: json['quantityTransferred'],
    );
  }
}