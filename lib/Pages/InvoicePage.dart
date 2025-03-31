import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craneapplication/components/MyDrawer.dart';
import 'package:craneapplication/features/auth/firebasestore.dart';
import 'package:flutter/material.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  List<Map<String,String>> invoices = [];
  int invoiceCount = 0;
  final FireStoreService fireStore = FireStoreService();

  void showInputDialog()
  {    
    final TextEditingController craneWeightController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController vehicleNumberController = TextEditingController();

    showDialog(
      context: context,
       builder: (context)
       {
          return AlertDialog(
            title: Text("Enter Invoice Details"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: craneWeightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Weight (ton)",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 25),

                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Price (RM)",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 25),

                  TextField(
                    controller: vehicleNumberController,
                    decoration: InputDecoration(
                      labelText: "Vehicle Number",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 25),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: ()=> Navigator.of(context).pop(),
                child: Text("Cancel"),
                ),
              ElevatedButton(
                onPressed: ()
                {
                  if(craneWeightController.text.isNotEmpty &&
                  priceController.text.isNotEmpty &&
                  vehicleNumberController.text.isNotEmpty)
                  {
                    setState(() {
                      invoiceCount++;
                      invoices.add({
                        "id":"$invoiceCount",
                        "weight":"${craneWeightController.text} ton",
                        "price": "RM${priceController.text}",
                        "vehicle":vehicleNumberController.text,
                      });
                      FireStoreService().addData(collection: "invoices",
                       data: {
                        "id":"$invoiceCount",
                        "weight":"${craneWeightController.text} ton",
                        "price": "RM${priceController.text}",
                        "vehicle":vehicleNumberController.text,    
                        "timestamp":Timestamp.now(),
                        "expiryTime":Timestamp.fromDate(DateTime.now().add(Duration(days:30))),
                      });
                    });
                    Navigator.of(context).pop();                    
                  }
                  else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("All fields are required!"),
                        duration: Duration(seconds: 2),
                        ),
                    );
                  }
                },
                child: Text("Add Invoice"),
              )
            ],
          );
       }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice"),        
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child:     
                invoices.isEmpty? Center(
                  child: Text(
                    "No Invoice Generated Yet.",
                    style: TextStyle(fontSize: 20),
                    ),
                )
              :ListView.builder(
                itemCount: invoices.length,
                itemBuilder: (context,index){
                  final invoice = invoices[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    color: const Color.fromARGB(255, 219, 169, 61),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(invoice["id"]!),                        
                      ),
                      title: Text("Invoice #${invoice["id"]!}"),
                      subtitle: Text.rich(
                        TextSpan(children: [
                            TextSpan(
                              text: "Weight: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "${invoice["weight"]}\n"),
                            TextSpan(
                              text: "Price: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "${invoice["price"]}\n"),
                            TextSpan(
                              text: "Vehicle: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: "${invoice["vehicle"]}"),
                          ],
                        ),
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),            
            ),
          ]        
          ),
        ),
      ),      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showInputDialog,
        icon: Icon(Icons.add),
        label: Text("Generate Invoice"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}