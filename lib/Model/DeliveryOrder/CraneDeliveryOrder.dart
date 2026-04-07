
import 'package:intl/intl.dart';

class CraneDeliveryOrder {
  final String doNumber;
  final String vehicleNumber;
  final int vehicleTon;

  CraneDeliveryOrder({
    required this.doNumber,
    required this.vehicleNumber,
    required this.vehicleTon,
  });

  String imageName()
  {
    String dateToday = DateFormat('yyyyMMdd').format(DateTime.now());
    String imageName = "${dateToday}_${vehicleNumber}_$vehicleTon.jpg";
    return imageName;
  }
}

