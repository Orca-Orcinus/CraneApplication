import 'package:craneapplication/Model/UserProfile/UserProfile.dart';
import 'package:craneapplication/Model/UserProfile/userService.dart';
import 'package:craneapplication/Pages/CraneDeliveryOrderPage.dart';
import 'package:craneapplication/Pages/DisplayJobPage.dart';
import 'package:craneapplication/Pages/LoginPage.dart';
import 'package:craneapplication/Pages/TimeSheetPage/OperatorTimeSheetPage.dart';
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
    _getUserData();
  }


  Future<Map<String, dynamic>> _getUserData() async {
    final results = await Future.wait([
      _userService.checkUserRole(),
      _userService.getUserName(),
    ]);
    return {
      'role': Rolesenum.values[results[0] as int],
      'userName': results[1] as String,
    };
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
          return FutureBuilder<Map<String, dynamic>>(
            future: _getUserData(),
            builder: (context, roleSnapshot) {
              if(roleSnapshot.connectionState == ConnectionState.waiting)
              {
                return const Center(child: CircularProgressIndicator());
              }
              if(roleSnapshot.hasError)
              {
                return Center(child: Text("Error: ${roleSnapshot.error}"));
              }
              String userName = roleSnapshot.data!['userName'];
              Rolesenum userRole = roleSnapshot.data!['role'] as Rolesenum;
              if(userRole == Rolesenum.Administrator) {
                // return ExcelViewerPage(username: _userService.getUserName());
                return const CraneDeliveryOrderPage();
              } else if(userRole == Rolesenum.Manager)              
                return const CraneDeliveryOrderPage();
                //return const DisplayJobPage();
              else if(userRole == Rolesenum.Account)
                return const DisplayJobPage();
              else if(userRole == Rolesenum.Foremen)
                return const DisplayJobPage();
              else if(userRole == Rolesenum.Operator)
                return OperatorTimesheetPage(operatorName: userName);
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