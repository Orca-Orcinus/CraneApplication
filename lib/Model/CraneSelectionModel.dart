import 'package:craneapplication/features/auth/firebasestore.dart';

class CraneSelectionModel {
  FireStoreService _db = FireStoreService();
  List<Map<String,String>> vehicleContent =[];  

  Future<List<Map<String,dynamic>>> getCraneData() async
  {
    return _db.getData(collection: 'vehicles');
  }

  //get company name from vehicle number
}