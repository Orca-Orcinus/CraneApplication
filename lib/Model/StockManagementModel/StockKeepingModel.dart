class StockKeepingModel{
  String itemCode;
  String itemDescription;
  String sku;
  String category;
  double unitCost;

  int quantity;
  int minStockLevel;
  int maxStockLevel;
  String unitOfMeasurement;

  DateTime? createdAt;
  DateTime? updatedAt;
  String createdBy;
  String? notes;

  StockKeepingModel({
    required this.itemCode,
    required this.itemDescription,
    required this.sku,
    required this.category,
    required this.unitCost,
    required this.quantity,
    required this.minStockLevel,
    required this.maxStockLevel,
    required this.unitOfMeasurement,
    required this.createdBy,
  });

  Map<String,dynamic> toJson()
  {
    return{
      "itemCode":itemCode,
      "itemDescription":itemDescription,
      "sku":sku,
      "category":category,
      "unitCost":unitCost,
      "quantity":quantity,
      "minStockLevel":minStockLevel,
      "maxStockLevel":maxStockLevel,
      "uom":unitOfMeasurement,
      "createdBy":createdBy,
      "updatedAt":DateTime.now(),      
    };
  }

  factory StockKeepingModel.fromJson(Map<String,dynamic> json)
  {
    return StockKeepingModel(
      itemCode: json['itemCode'], 
      itemDescription: json['itemDescription'], 
      sku: json['sku'], 
      category: json['category'], 
      unitCost: json['unitCost'], 
      quantity: json['quantity'], 
      minStockLevel: json['minStockLevel'], 
      maxStockLevel: json['maxStockLevel'], 
      unitOfMeasurement: json['unitOfMeasurement'],
      createdBy: json['createdBy']);
  }
}