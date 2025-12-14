class StockItemModel{
  String itemCode;
  String itemDescription;
  String itemGroup;
  String unitOfMeasurement;
  double purchaseCost; //Ref. Cost
  double salesPrice; //Ref. Price
  
  StockItemModel({
    required this.itemCode,
    required this.itemDescription,
    required this.itemGroup,
    required this.unitOfMeasurement,
    required this.purchaseCost,
    required this.salesPrice,
  });

  Map<String,dynamic> toJson(){
    return {
      'itemCode': itemCode,
      'itemDescription': itemDescription,
      'itemGroup': itemGroup,
      'unitOfMeasurement': unitOfMeasurement,
      'purchaseCost': purchaseCost,
      'salesPrice': salesPrice,
    };
  }

  factory StockItemModel.fromJson(Map<String, dynamic> json) {
    return StockItemModel(
      itemCode: json['itemCode'],
      itemDescription: json['itemDescription'],
      itemGroup: json['itemGroup'],
      unitOfMeasurement: json['unitOfMeasurement'],
      purchaseCost: json['purchaseCost'],
      salesPrice: json['salesPrice'],
    );
  }
}