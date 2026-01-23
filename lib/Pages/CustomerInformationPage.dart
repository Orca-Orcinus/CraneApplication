import 'package:craneapplication/Model/UserProfile/CustomerProfile.dart';
import 'package:craneapplication/components/MyButton.dart';
import 'package:craneapplication/components/MyDrawer.dart';
import 'package:flutter/material.dart';

class CustomerInformationPage extends StatefulWidget {
  const CustomerInformationPage({super.key});

  @override
  State<CustomerInformationPage> createState() => _CustomerInformationPageState();
}

class _CustomerInformationPageState extends State<CustomerInformationPage> {
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerContactController = TextEditingController();
  final TextEditingController customerAddressController = TextEditingController();
  final TextEditingController customerEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Information"),
      ),
      drawer: MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: customerNameController,
            decoration: const InputDecoration(
              labelText: "Customer Name",
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: customerContactController,
            decoration: const InputDecoration(
              labelText: "Customer Contact",
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: customerAddressController,
            decoration: const InputDecoration(
              labelText: "Customer Address",
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: customerEmailController,
            decoration: const InputDecoration(
              labelText: "Customer Email",
            ),
          ),
          const SizedBox(height: 20),
          MyButton(btnName: "Add Customer", onClick: ()=> addCustomerInformation()),
        ],
      ),
    );
  }

  void addCustomerInformation() {
    String name = customerNameController.text;
    String contact = customerContactController.text;
    String address = customerAddressController.text;
    String email = customerEmailController.text;

    CustomerProfile customer = CustomerProfile(
      customerName: name,
      customerPhoneNumber: contact,
      customerAddress: address,
      customerEmail: email,
      createdBy: 'admin',
    );
    
    CustomerDatabaseControl().addCustomer(customer);
    // Add your logic to handle the customer information here
  }
}