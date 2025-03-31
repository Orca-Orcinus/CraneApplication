import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craneapplication/Model/UserProfile/UserProfile.dart';
import 'package:craneapplication/components/MyDrawer.dart';
import 'package:craneapplication/features/auth/firebasestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final TextEditingController userNameControler = TextEditingController();
  final TextEditingController userEmailAddressController = TextEditingController();
  String userRole = "Loading...";
  bool isLoading = true;

  @override
  void initState()
  {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async
  {
    try
    {
      UserProfile profile = UserProfile();
      Map<String,dynamic>? userData = await profile.getUserData("userDetails");

      setState(() {
        userNameControler.text = userData?['name'] ?? 'Unknown';
        userEmailAddressController.text = userData?['emailAddress'];
        userRole = userData?['roles'];
        isLoading = false;
      });
    }
    catch(e)
    {
      print("$e");
    }
  }

  Future<String> getUserDocumentId(String userCollection) async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(userCollection)
        .where("uid", isEqualTo: user?.uid)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id; // Get the first matching document ID
    } else {
      print("User document not found.");
      return "";
    }
  } catch (e) {
    print("Error fetching document ID: $e");
    return "";
  }
}


  Future<void> updateUserProfile()async
  {
    try
    {
      final User? user = FirebaseAuth.instance.currentUser;
      if(user == null) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)
        {
          return const AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Updating Profile.."),
              ],
            ),
          );
        }
      );

      String userDocId = await getUserDocumentId("userDetails");
      
      await FireStoreService().updateData(collection: "userDetails", documentId: userDocId, data: {
        'name':userNameControler.text.trim(),
        'emailAddress':userEmailAddressController.text.trim(),
      });

      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (context)
        {
          return const AlertDialog(
            title: Text("Success"),
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Profile Updated Completely.."),                
              ],
            ),
          );
        }
      );
      await Future.delayed(const Duration(seconds: 1));

      if(context.mounted) {
        Navigator.pop(context);
      }
    }
    catch(e)
    {
      Navigator.pop(context);

      // Show error pop-up
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text("Failed to update profile: $e"),            
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Information")),
      drawer: MyDrawer(),
      body: isLoading? 
        const Center(child: CircularProgressIndicator())
        :Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(controller: userNameControler, 
                decoration: const InputDecoration(
                  labelText: 'Name',
                    border: OutlineInputBorder(),
                )
                ),

                const SizedBox(height: 10),

                TextField(controller: userEmailAddressController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: TextEditingController(text:userRole),
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Credentials Level",
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),
                ElevatedButton(onPressed: updateUserProfile, child: const Text("Update Profile")),
              ],
            ),
          ),
    );
  }
}