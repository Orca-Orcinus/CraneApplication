import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craneapplication/Model/ApplicationTool/imageService.dart';
import 'package:craneapplication/Model/UserProfile/userService.dart';
import 'package:craneapplication/components/MyButton.dart';
import 'package:craneapplication/components/MyDrawer.dart';
import 'package:craneapplication/components/pdf.dart';
import 'package:craneapplication/enum/RolesEnum.dart';
import 'package:craneapplication/features/auth/fbStorage.dart';
import 'package:craneapplication/features/auth/firebasestore.dart';
import 'package:flutter/material.dart';
import 'package:craneapplication/components/pdf.dart';

class CraneSelectionPage extends StatefulWidget {
  const CraneSelectionPage({super.key});

  @override
  State<CraneSelectionPage> createState() => _CraneSelectionPageState();
}

class _CraneSelectionPageState extends State<CraneSelectionPage> {
  List<Map<String,dynamic>> jobList = [];
  int jobCount = 0;
  final FireStoreService _dbService = FireStoreService();  
  final UserService _userService = UserService();
  final TextEditingController workOrderController = TextEditingController();

  final ImageService _imageService = ImageService();
  final FBStorage fbStorageTool = FBStorage();

  @override
  void initState()
  {
     super.initState();
    getOperatorJobData();
  }

  Future<void> prepareData() async
  {
    await fetchOperators();
    await fetchVehicles();
  }

  Future<List<Map<String,dynamic>>> getJobData() async
  {
    return _dbService.getData(collection: "JobInfo");
  }

  Future<void> getOperatorJobData() async
  {
    List<Map<String,dynamic>> allJobs = await getJobData();   
    Map<String,dynamic>? userInfo = await _userService.getUserCredentials();
    
    if(userInfo?['roles'] == Rolesenum.Manager.toString())
    {
      jobList = allJobs;
    }

    if(mounted)
    {
      setState(() {});
    }
  }


  Future<List<String>> fetchOperators() async
  {
      try
      {
        List<Map<String,dynamic>> allUsers = await _dbService.getData(collection: 'userDetails');

        //Filter users where roles == operators
        List<Map<String,dynamic>> operatorData = allUsers.where((user) => user['roles'] == Rolesenum.Operator.toString()).toList();
          
        return operatorData.map((doc)=> doc['name'] as String).toList();          
      }
      catch(e)
      {
        print("Error fetching operators: $e");
        return [];
      }
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

  void onAddJobPressed() async
  {
    await prepareData();
    AddCraneTask();
  }

  void AddCraneTask() async
  {
    final TextEditingController customerContactController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController tonnageController = TextEditingController();
    final TextEditingController workdayController = TextEditingController();        

    String? selectedOperator;
    List<Map<String,dynamic>> selectedWorkDay = [];
    String? selectedVehicle;

    List<String> operatorList = await fetchOperators();
    List<String> vehicleNumberList = await fetchVehicles();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Assign Job"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    // Select Operator Dropdown (Now displays selected value inside the field)
                    DropdownButtonFormField<String>(
                      value: selectedOperator,
                      items: operatorList.map((operator) {
                        return DropdownMenuItem<String>(
                          value: operator,
                          child: Text(operator),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedOperator = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: "Select Operator",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Customer Contact Input
                    TextField(
                      controller: customerContactController,
                      decoration: const InputDecoration(
                        labelText: "Customer Contact",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 25),

                    //Tonnage Input
                    TextField(
                      controller: tonnageController,
                      decoration: const InputDecoration(
                        labelText: "Weight(in tons)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Select Vehicle Dropdown (Displays selected vehicle inside the field)
                    DropdownButtonFormField<String>(
                      value: selectedVehicle,
                      items: vehicleNumberList.map((vehicleNumber) {
                        return DropdownMenuItem<String>(
                          value: vehicleNumber,
                          child: Text(vehicleNumber),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedVehicle = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: "Select Vehicle",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Location Input
                    TextField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        labelText: "Location",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Work Day Selection (Displaying selected date inside the field)
                    TextField(
                      readOnly: true,
                      controller: workdayController,
                      decoration: const InputDecoration(
                        labelText: "Working Date",
                        border: OutlineInputBorder(),
                      ),
                      onTap: () async {
                        List<DateTime>? pickedDates = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2501),
                        ).then((range)=> range == null ? null
                        : List.generate(range.end.difference(range.start).inDays + 1,
                        (index)=> range.start.add(Duration(days: index))));

                        if(pickedDates != null && pickedDates.isNotEmpty)
                        {
                          setDialogState(() {
                            selectedWorkDay = pickedDates.map((date){
                              return {
                                "date":date.day,
                                "shift":"Full-Day",
                              };
                            }).toList();
                            workdayController.text = selectedWorkDay
                              .map((d) =>
                                  "${d["date"]} (${d["shift"]})")
                              .join(", ");
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 20),

                    if(selectedWorkDay.isNotEmpty)                    
                      Column(
                      children: selectedWorkDay.map((workDay)
                      {
                        return ListTile(
                          title: Text("Date:${workDay["date"].day}"),
                          subtitle: DropdownButtonFormField(
                            value: workDay["shift"],
                            items: ["Full-Day","AM","PM"].map((shift)
                            {
                              return DropdownMenuItem<String>(
                                value: shift,
                                child: Text(shift),
                              );
                            }).toList(),
                            onChanged: (value)
                            {
                              setDialogState(()
                              {
                                workDay["shift"] = value!;
                                workdayController.text = selectedWorkDay
                                    .map((d) =>
                                        "${d["date"].toString().split("T")[0]} (${d["shift"]})")
                                    .join(", ");
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (customerContactController.text.isEmpty ||
                        selectedOperator == null ||
                        selectedWorkDay.isEmpty ||
                        selectedVehicle == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("All fields are required!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      setState(() {
                        jobCount++;
                        jobList.add({
                          "id": "$jobCount",
                          "operator": selectedOperator!,
                          "customerContact": customerContactController.text,
                          "vehicle": selectedVehicle!,
                          "workday": selectedWorkDay.toString(),
                          "location": locationController.text,
                          "weight":tonnageController.text,
                        });
                      });

                      _dbService.addData(
                        collection: "JobInfo",
                        data: {
                          "id": "$jobCount",
                          "operator": selectedOperator!,
                          "customerContact": customerContactController.text,
                          "vehicle": selectedVehicle!,
                          "workday": selectedWorkDay,
                          "location": locationController.text,
                          "weight":tonnageController.text,
                          "workOrderNo":"",
                          "timestamp": Timestamp.now(),
                          "expiryTime":Timestamp.fromDate(DateTime.now().add(Duration(days:30))),
                          "workorder_images": [], // Initialize as empty array
                          "onsitearrival_images": [], // Initialize as empty array
                        },
                      );

                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Add Job"),
                ),
              ],
            );
          },
        );
      },
    );
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
                
                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(                  
                    icon: Icon(Icons.content_paste_go_rounded),
                    label:Text("Generate Invoice"),
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
                      _generateInvoicePdf(jobId);
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

  void _generateInvoicePdf(String jobId) async
  {
    var docId = await fbStorageTool.getJobDocumentId(collection: "JobInfo",jobId: jobId);
    if(docId != null)
    {
      var data = await _dbService.getSpecificData(collection: "JobInfo", id: docId);
      var filePath = await generateInvoicePDF(data);
      await sharePDF(filePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crane Selection"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child:     
                jobList.isEmpty
                ? Center(
                  child: Text(
                    "No Job Generated Yet.",
                    style: TextStyle(fontSize: 20),
                    ),
                )
              :ListView.builder(
                itemCount: jobList.length,
                itemBuilder: (context,index){
                  final job = jobList[index];
                  return GestureDetector(
                  onTap: ()
                  {
                    _selectWorkOrderOrOnsiteArrival(job["id"]);
                  },
                  child:  Card(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    color: const Color.fromARGB(255, 219, 169, 61),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(job["id"]!),                        
                      ),
                      title: Text("Job #${job["id"]!}"),
                      subtitle: Text.rich(
                        TextSpan(children: [
                            TextSpan(
                              text: "Customer Contact: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "${job["customerContact"]}\n"),
                            TextSpan(
                              text: "Day: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "${job["workday"]}\n"),
                            TextSpan(
                              text: "Vehicle Number: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "${job["vehicle"]}\n"),       
                            TextSpan(
                              text: "Work Place: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "${job["weight"]}\n"),
                            TextSpan(
                              text: "Tonnage: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "${job["weight"]}\n"),
                          ],
                        ),
                      ),
                    ),
                  )
                  );
                },
              ),            
            ),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async
        {
          await prepareData();
          AddCraneTask();
        },
        label: Text("Add Job")
        ),
    );
  }
}