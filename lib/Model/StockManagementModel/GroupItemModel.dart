
enum CostingMethod {
  FIFO,
  FixedCosting,
  WeightedAverage,
}


class GroupItemModel {
  String itemCode;
  String itemDescription;
  CostingMethod costingMethod = CostingMethod.WeightedAverage;

  String salesCode;
  String cashSalesCode;
  String salesReturnCode;
  String purchaseCode;
  String cashPurchaseCode;
  String purchaseReturnCode;
  
  GroupItemModel({
    required this.itemCode,
    required this.itemDescription,
    required this.salesCode,
    required this.cashSalesCode,
    required this.salesReturnCode,
    required this.purchaseCode,
    required this.cashPurchaseCode,
    required this.purchaseReturnCode,
  });

  Map<String,dynamic> toJson(){
    return {
      'itemCode': itemCode,
      'itemDescription': itemDescription,
      'costingMethod': costingMethod.toString().split('.').last,
      'salesCode': salesCode,
      'cashSalesCode': cashSalesCode,
      'salesReturnCode': salesReturnCode,
      'purchaseCode': purchaseCode,
      'cashPurchaseCode': cashPurchaseCode,
      'purchaseReturnCode': purchaseReturnCode,
    };
  }

  factory GroupItemModel.fromJson(Map<String, dynamic> json) {
    return GroupItemModel(
      itemCode: json['itemCode'],
      itemDescription: json['itemDescription'],
      salesCode: json['salesCode'],
      cashSalesCode: json['cashSalesCode'],
      salesReturnCode: json['salesReturnCode'],
      purchaseCode: json['purchaseCode'],
      cashPurchaseCode: json['cashPurchaseCode'],
      purchaseReturnCode: json['purchaseReturnCode'],
    );
  }
}