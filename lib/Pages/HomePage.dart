import 'package:craneapplication/Model/UserProfile/UserProfile.dart';
import 'package:craneapplication/Model/UserProfile/userService.dart';
import 'package:craneapplication/Pages/DisplayJobPage.dart';
import 'package:craneapplication/Pages/LoginPage.dart';
import 'package:craneapplication/Pages/WarehouseSelectionPage.dart';
import 'package:craneapplication/enum/RolesEnum.dart';
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

  Future<Rolesenum> getRole() async
  {
    var roleIndex = await _userService.checkUserRole();
    Rolesenum userRole = Rolesenum.values[roleIndex];
    return userRole;
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
          return FutureBuilder<Rolesenum>(
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
              if(roleSnapshot.data == Rolesenum.Administrator) {
                return const WarehouseSelectionPage();
              } else if(roleSnapshot.data == Rolesenum.Manager)              
                return const WarehouseSelectionPage();
                //return const DisplayJobPage();
              else if(roleSnapshot.data == Rolesenum.Account)
                return const DisplayJobPage();
              else if(roleSnapshot.data == Rolesenum.Foremen)
                return const DisplayJobPage();
              else if(roleSnapshot.data == Rolesenum.Operator)
                return const DisplayJobPage();
              else
                return const SizedBox.shrink();
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