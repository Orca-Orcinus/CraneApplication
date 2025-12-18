import 'package:craneapplication/Pages/GroupItemPage.dart';
import 'package:craneapplication/Pages/LoginPage.dart';
import 'package:craneapplication/Pages/StockDataPage.dart';
import 'package:craneapplication/Pages/StockReceivedItemPage.dart';
import 'package:craneapplication/Pages/StockTransferItemPage.dart';
import 'package:craneapplication/Pages/StockWarehousePage.dart';
import 'package:craneapplication/components/MyButton.dart';
import 'package:craneapplication/components/MyDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WarehouseSelectionPage extends StatefulWidget {
  const WarehouseSelectionPage({super.key});
 @override
  State<WarehouseSelectionPage> createState() => _WarehouseSelectionPageState();
}

class _WarehouseSelectionPageState extends State<WarehouseSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Database"),
      ),
      drawer: MyDrawer(),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context,snapshot)
        {
          if(snapshot.hasData)
          {
            if(snapshot.connectionState == ConnectionState.waiting)
            {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(
              child: Column(                           
              mainAxisSize: MainAxisSize.min,
              children: [
                MyButton(btnName: "Stock Item", onClick: () => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const StockDataPage()))),

                const SizedBox(height: 10),

                MyButton(btnName: "Stock Received Item", onClick: () => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const StockReceivedItemPage()))),

                const SizedBox(height: 10),

                MyButton(btnName: "Transfer Item", onClick: () => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const StockTransferItemPage()))),

                const SizedBox(height: 10),

                MyButton(btnName: "Group Item", onClick: () => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const GroupItemPage()))),

                const SizedBox(height: 10),

                MyButton(btnName: "Stock Warehouse", onClick: () => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const StockWarehousePage()))),

                const SizedBox(height: 10),
              ]),
            );
          }
          else
          {
            return const LoginPage();
          }
        })
      );
  }
}