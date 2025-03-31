import 'package:craneapplication/Model/UserProfile/UserProfile.dart';
import 'package:craneapplication/Model/UserProfile/userService.dart';
import 'package:craneapplication/Pages/CraneSelectionPage.dart';
import 'package:craneapplication/Pages/DisplayJobPage.dart';
import 'package:craneapplication/Pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
{
  final UserProfile userProfile = UserProfile();
  final UserService _userService = UserService();
  bool? isAdministrativeRole;

  @override
  void initState() {
    super.initState();
    userHandling();
  }

  void userHandling() async
  {
    await _userService.getUserCredentials();
    getRole();
  }

  Future<bool> getRole() async
  {
    bool role = await _userService.checkRole();
    return role;   
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot)
      {
        if(snapshot.hasData)
        {          
          return FutureBuilder<bool>(
            future: getRole(),
            builder: (context,roleSnapshot)
            {
              if(roleSnapshot.connectionState == ConnectionState.waiting)
              {
                return const Center(child: CircularProgressIndicator());
              }
              if(roleSnapshot.hasError)
              {
                return Center(child: Text("Error: ${roleSnapshot.error}"));
              }
              return roleSnapshot.data == true
                ? const CraneSelectionPage()
                : const DisplayJobPage();
            });
        }
        else
        {
          return const LoginPage();
        }
      }),
    );
  }
}