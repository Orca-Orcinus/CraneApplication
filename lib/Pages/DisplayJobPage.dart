import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:craneapplication/Model/ApplicationTool/imageService.dart';
import 'package:craneapplication/Model/UserProfile/userService.dart';
import 'package:craneapplication/components/MyButton.dart';
import 'package:craneapplication/components/MyDrawer.dart';
import 'package:craneapplication/enum/RolesEnum.dart';
import 'package:craneapplication/features/auth/firebasestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DisplayJobPage extends StatefulWidget {
  const DisplayJobPage({super.key});

  @override
  State<DisplayJobPage> createState() => _DisplayJobPageState();
}

class _DisplayJobPageState extends State<DisplayJobPage> {

  final FireStoreService _dbService = FireStoreService();
  final UserService _userService = UserService();
  final ImageService _imageService = ImageService();
  final TextEditingController workOrderController = TextEditingController();
  List<Map<String,dynamic>> operatorJobData = [];
  String? _base64Image;

  @override
  void initState()
  {
    super.initState();
    getOperatorJobData();
  }

  Future<List<Map<String,dynamic>>> getJobData() async
  {
    return _dbService.getData(collection: "JobInfo");
  }

  Future<String> _getImagePath(String fileName) async {
    // Get the external storage directory (e.g., Downloads folder)
    final directory = await getExternalStorageDirectory();
    final downloadsPath = '${directory?.path}/Download'; // Path to the Downloads folder

    // Example image file name in the Downloads folder
    String imageFileName = '$fileName.jpg';

    // Full path to the image
    return '$downloadsPath/$imageFileName';
  }

  Future<void> _compressAndEncodeImage(String fileName) async {
    // Get the image path
    final imagePath = await _getImagePath(fileName);
    final file = File(imagePath);

    // Check if the file exists
    if (!await file.exists()) {
      print('Image file does not exist at path: $imagePath');
      return;
    }

    // Compress the image
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      file.absolute.path + '_compressed.jpg',
      quality: 50, // Adjust quality as needed
    );

    if (compressedFile != null) {
      // Read the compressed file as bytes
      final bytes = await compressedFile.readAsBytes();

      // Convert the bytes to Base64
      final base64String = base64Encode(bytes);

      // Update the UI
      setState(() {
        _base64Image = base64String;
      });
    }
  }
  
  Future<void> _shareBase64Image() async {
    if (_base64Image == null) {
      print('No image to share.');
      return;
    }

    // Share the Base64 image as text
    await Share.share('Check out this image: data:image/jpeg;base64,$_base64Image');
  }

  Future<void> getOperatorJobData() async
  {
    List<Map<String,dynamic>> allJobs = await getJobData();   
    Map<String,dynamic>? userInfo = await _userService.getUserCredentials();
    
    if(userInfo?['roles'] == Rolesenum.Operator.toString())
    {
      operatorJobData = allJobs.where((job) => job['operator'] == userInfo?['name']).toList();
    }
    else if(userInfo?['roles'] == Rolesenum.Manager.toString())
    {
      operatorJobData = allJobs;
    }

    if(mounted)
    {
      setState(() {});
    }
  }

  void registerWorkOrderNumber(String jobId) async
  {
    await _imageService.inputWorkOrderNo(jobId, documentType.workOrder, workOrderController.text);                      
    _showImagePickOptions(jobId,documentType.workOrder);
  }

  Future<void> displayWorkOrderInputRequest(String jobId) async
  {
    showDialog(context: context, builder: (context)
    {
      return StatefulBuilder(builder: (context,setDialogState)
      {
        return AlertDialog(
          title: Text("Input Work Order No."),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  TextFormField(
                    controller: workOrderController,
                    decoration: InputDecoration(
                      labelText: "Work Order No.",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                MyButton(btnName: "Submit", onClick: () => registerWorkOrderNumber(jobId)),
              ],
            ),
          ),
        );
      });
    });
  }

  void _selectWorkOrderOrOnsiteArrival(String jobId)
  {
    showDialog(context: context, builder: (context)
    {
      return StatefulBuilder(builder: (context,setDialogState)
      {
        return AlertDialog(
          title: Text("Upload Document"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.assignment,size: 24),
                    label: Text("Work Order"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async
                    {                    
                      Navigator.pop(context);
                      await displayWorkOrderInputRequest(jobId);                        
                    },
                  ),
                ),                

                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(                  
                    icon: Icon(Icons.construction_rounded),
                    label:Text("On Site Arrival"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),     
                      minimumSize: Size(double.infinity, 50), // Set minimum height               
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),                      
                      ),
                    ),
                    onPressed: ()
                    {
                      Navigator.pop(context);
                      _showImagePickOptions(jobId, documentType.onSiteArrival);
                    }
                  ),
                ),             
              ],
            ),
          ),
        );
      });
    });
  }

  void _showImagePickOptions(String jobId,documentType documentType)
  {
    showModalBottomSheet(context: context, builder: (BuildContext context)
    {
      return SafeArea(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Choose from Gallery"),
            onTap: (){
              Navigator.pop(context);
              _imageService.pickImage(jobId,documentType);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt_rounded),
            title : const Text("Take a picture"),
            onTap: ()
            {
              Navigator.pop(context);
               _imageService.takePicture(jobId,documentType);
            },
          ),
        ],
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Display"),        
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(25.0)),
            Expanded(
              child: 
              operatorJobData.isEmpty ? 
              Center(child: Text("No Job Assigned."))
              : ListView.builder(
                itemCount: operatorJobData.length,
                itemBuilder:(context, index)
                  {
                    final operatorContent = operatorJobData[index];
                    return GestureDetector(
                    onTap: ()
                    {
                      _selectWorkOrderOrOnsiteArrival(operatorContent["id"]);
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      color: const Color.fromARGB(255, 219, 169, 61),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(operatorContent["id"]!),
                        ),
                        title: Text("Job #${operatorContent["id"]!}"),
                            subtitle: Text.rich(
                        TextSpan(children: [
                            TextSpan(
                              text: "Customer Contact: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "${operatorContent["customerContact"]}\n"),
                            TextSpan(
                              text: "Day: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "${operatorContent["workday"]}\n"),
                            TextSpan(
                              text: "Vehicle Number: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "${operatorContent["vehicle"]}\n"),       
                            TextSpan(
                              text: "Work Place: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "${operatorContent["location"]}\n"),
                            TextSpan(
                              text: "Tonnage: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "${operatorContent["weight"]}"),
                          ],
                        ),
                      ),
                      ),
                      ),
                    );
                  },
                ),
            ),
          ],
        ),
        ),
    );
  }
}