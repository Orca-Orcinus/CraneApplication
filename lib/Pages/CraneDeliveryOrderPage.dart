import 'dart:io';

import 'package:craneapplication/Model/ApplicationTool/imageService.dart';
import 'package:craneapplication/Model/DeliveryOrder/CraneDeliveryOrder.dart';
import 'package:craneapplication/components/MyButton.dart';
import 'package:craneapplication/components/MyDrawer.dart';
import 'package:flutter/material.dart';
import 'package:craneapplication/features/auth/firebasestore.dart';
import 'package:image_picker/image_picker.dart';

class CraneDeliveryOrderPage extends StatefulWidget {
  const CraneDeliveryOrderPage({super.key});

  @override
  State<CraneDeliveryOrderPage> createState() => _CraneDeliveryOrderPageState();
}

class _CraneDeliveryOrderPageState extends State<CraneDeliveryOrderPage> {
  final FireStoreService _dbService = FireStoreService();  
  final ImageService _imageService = ImageService();

  final TextEditingController doNumberController = TextEditingController();
  final TextEditingController vehicleTonController = TextEditingController();

  String? selectedVehicle;  
  CraneDeliveryOrder? craneDeliveryOrder;
  List<String> vehicleNumberList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async
  {
    final data = await fetchVehicles();
    setState(() {
      vehicleNumberList = data;
    });
  }

  Future<List<String>> fetchVehicles() async
  {
    try
    {
      List<Map<String,dynamic>> vehicleData = 
      await _dbService.getData(collection: 'vehicles');
      return vehicleData.map((doc) => doc['vehicleNumber'] as String).toList();       
    }
    catch(e)
    {
      print("Error fetching vehicle: $e");
      return [];
    }
  }

void _showImagePickOptions(CraneDeliveryOrder cDeliveryOrder) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Choose from Gallery"),
              onTap: () {
                Navigator.pop(context);
                // ✅ pickImage already uses image.path correctly
                _imageService.pickImage(
                  cDeliveryOrder.doNumber,
                  documentType.deliveryOrder,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text("Take a picture"),
              onTap: () {
                Navigator.pop(context);
                // ✅ Now correctly copies captured image to imageName() path
                _imageService.takePicture(
                  cDeliveryOrder.doNumber,
                  documentType.deliveryOrder,
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

  void registerDeliveryOrder(CraneDeliveryOrder cDeliveryOrder) async
  {
    await _imageService.inputDeliveryOrderNo(cDeliveryOrder.doNumber, documentType.workOrder, cDeliveryOrder.doNumber);
    _showImagePickOptions(cDeliveryOrder);
  }

  Future<void> AddDeliveryOrderInfo() async
  {
      File? selectedImage;

      craneDeliveryOrder = CraneDeliveryOrder(
        doNumber: doNumberController.text,
        vehicleNumber: selectedVehicle ?? '',
        vehicleTon: int.tryParse(vehicleTonController.text) ?? 0,
      );

      showDialog(
      context: context,
      builder: (context)
      {
        return StatefulBuilder(
         builder: (context,setDialogState) {
            return AlertDialog(
              title: Text('Add Delivery Order Info'),
              content: SingleChildScrollView(            
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Show preview if image is picked
                    const SizedBox(height: 10),

                    // Pick from camera
                    ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text("Choose from Gallery"),
                      onTap: (){
                        Navigator.pop(context);
                        // _imageService.pickAndSaveImageToPath(craneDeliveryOrder!.doNumber, documentType.deliveryOrder,craneDeliveryOrder!.imageName());
                        _imageService.pickImage(
                          craneDeliveryOrder!.doNumber,
                          documentType.deliveryOrder,
                         );

                         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Save Complete!'))
                         );
                      },
                    ),
                  ],
                ),           
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();             
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crane Delivery Order'),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: doNumberController,
              decoration: InputDecoration(labelText: 'DO Number'),
            ),

            const SizedBox(height: 20),

            // Select Vehicle Dropdown (Displays selected vehicle inside the field)
            DropdownButtonFormField<String>(
              initialValue: selectedVehicle,
              items: vehicleNumberList.map((vehicleNumber) {
                return DropdownMenuItem<String>(
                  value: vehicleNumber,
                  child: Text(vehicleNumber),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedVehicle = value;
                });
              },
              decoration: const InputDecoration(
                labelText: "Select Vehicle",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: vehicleTonController,
              decoration: InputDecoration(labelText: 'Vehicle Ton'),
              keyboardType: TextInputType.number,
            ),                                            // *** ADD THIS SUBMIT BUTTON ***
            const SizedBox(height: 20),
            ElevatedButton(            
              onPressed: AddDeliveryOrderInfo, // <-- Call the new submission handler
              child: const Text('Submit Delivery Order'),              
            ),
          ],
        ),
      ),
    );
  }
}