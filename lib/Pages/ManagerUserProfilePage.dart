import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craneapplication/components/MyDrawer.dart';
import 'package:craneapplication/enum/RolesEnum.dart';
import 'package:craneapplication/features/auth/firebasestore.dart';
import 'package:flutter/material.dart';

class ManagerUserProfilePage extends StatefulWidget {
  const ManagerUserProfilePage({super.key});

  @override
  State<ManagerUserProfilePage> createState() => _ManagerUserProfilePageState();
}

class _ManagerUserProfilePageState extends State<ManagerUserProfilePage> {
  final FireStoreService fsService = FireStoreService();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userEmailAddressController = TextEditingController();
  Rolesenum userRole = Rolesenum.None;
  bool isLoading = true;
  List<Map<String,dynamic>> users = [];
  String? selectedUserEmail;

  @override
  void initState()
  {
    super.initState();
    fetchUserProfile();
  }

  Rolesenum stringToRoleEnum(String role) {
    Rolesenum valItem = Rolesenum.values.firstWhere(
      (e) => e.toString() == role,
      orElse: () => Rolesenum.None);
    return valItem;
  }

  Future<void> fetchUserProfile() async
  {
    try
    {
      List<Map<String, dynamic>?> allUserData = await fsService.getData(collection: "userDetails").then((value) => value.whereType<Map<String, dynamic>>().toList());

      setState(() {
        users = allUserData.whereType<Map<String, dynamic>>().toList();
        isLoading = false;
      });
    }
    catch(e)
    {
      print("$e");
    }
  }

  void OnUserSelected(String? emailAddress)
  {
    if(emailAddress == null) return;

    setState(() {
      selectedUserEmail = emailAddress;
      isLoading = true;
    });

    try
    {
      var selectedUser = users.firstWhere((user)=> user['emailAddress'] == emailAddress, orElse: () => {});
      if(selectedUser.isNotEmpty)
      {
        setState(() {
          userNameController.text = selectedUser['name'] ?? '';
          userEmailAddressController.text = selectedUser['emailAddress'];
          userRole = stringToRoleEnum(selectedUser['roles']);
          isLoading = false;
        });
      }
    }
    catch(e)
    {
      print("$e");
    }

  }


 Future<void> updateUserProfile()async
  {
    try
    {
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
        'name':userNameController.text.trim(),
        'emailAddress':userEmailAddressController.text.trim(),
        'roles': userRole.toString(),
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

  Future<String> getUserDocumentId(String userCollection) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(userCollection)
        .where("emailAddress", isEqualTo: selectedUserEmail)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Profile Information")),
      drawer:MyDrawer(),
      body: isLoading? const Center(child: CircularProgressIndicator()) : 
      Padding(padding: EdgeInsets.all(25.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: selectedUserEmail,
              hint: Text("Select a User"),
              onChanged: OnUserSelected,
              items: users.map((user)
              {
                return DropdownMenuItem<String>(
                  value:user["emailAddress"],
                  child: Text(user['emailAddress']),
                );
              }).toList(),
            ),

            SizedBox(height: 20),

            TextField(
              controller: userNameController,
              decoration: InputDecoration(labelText: "Name",border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.5))),
            ),
            SizedBox(height: 20),
            TextField(
              controller: userEmailAddressController,
              decoration: InputDecoration(labelText: "Email Address",border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.5))),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<Rolesenum>(
                value: userRole,
                hint: Text("Select a Role"),
                onChanged: (Rolesenum? newRole) {
                  if (newRole != null) {
                    setState(() {
                      userRole = newRole;
                    });
                  }
                },
                items: Rolesenum.values.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role.toString().split('.').last),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateUserProfile,
                child: Text("Update Profile"),
              ),
          ],
        ),
      ),
    );
  }
}