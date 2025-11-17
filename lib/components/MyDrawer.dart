import 'package:craneapplication/Model/UserProfile/userService.dart';
import 'package:craneapplication/Pages/HomePage.dart';
import 'package:craneapplication/Pages/InvoicePage.dart';
import 'package:craneapplication/Pages/ManagerUserProfilePage.dart';
import 'package:craneapplication/Pages/UserProfilePage.dart';
import 'package:craneapplication/auth/AuthPage.dart';
import 'package:craneapplication/enum/RolesEnum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});
  
  final UserService user = UserService();

  Future<Rolesenum> checkCurrentUser() async
  {
    var roleIndex = await user.checkUserRole();
    Rolesenum userRole = Rolesenum.values[roleIndex];
    return await userRole;
  }

  void logout() async
  {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: FutureBuilder<Rolesenum>(
          future: checkCurrentUser(),
          builder: (context,snapshot)
          {
            if(snapshot.connectionState == ConnectionState.waiting)
            {
              return const Center(child: CircularProgressIndicator());
            }

            if(snapshot.hasError)
            {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                      const DrawerHeader(child: Icon(Icons.person_sharp)),

                                      const SizedBox(height:5),
                                               
                                      Padding(
                                        padding: const EdgeInsets.only(left: 25),
                                        child : ListTile(
                                          leading: const Icon(Icons.home),
                                          title: const Text("H O M E"),
                                          onTap: () {
                                            Navigator.pop(context);

                                            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                                          },
                                        ),
                                      ),            

                                      const SizedBox(height:5),                                   

                                      if(user.isAdmin)      
                                      ...[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 25),
                                          child: ListTile(
                                            leading: const Icon(Icons.edit_document),    
                                            title:const Text("I N V O I C E"),
                                            onTap:() {
                                              Navigator.pop(context);

                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const InvoicePage()));
                                            },
                                          ),
                                        ),    
                                        const SizedBox(height: 5),
                                      ],                                

                                      Padding(
                                        padding: const EdgeInsets.only(left: 25),
                                        child: ListTile(
                                          leading: const Icon(Icons.person_2),    
                                          title:const Text("P R O F I L E"),
                                          onTap:() {
                                            Navigator.pop(context);

                                            Navigator.push(context, MaterialPageRoute(builder: (context) => 
                                             user.isAdmin? ManagerUserProfilePage() : UserProfilePage()));
                                          },
                                        ),
                                      ),    
                                      
                                      const SizedBox(height: 5),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 25),
                                        child: ListTile(
                                          leading: const Icon(Icons.settings),    
                                          title:const Text("S E T T I N G S"),
                                          onTap:() {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),    

                                      const SizedBox(height: 5),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left:25,bottom:50),
                                child: ListTile(
                                  leading : const Icon(Icons.logout),
                                  title: const Text("L O G O U T"),
                                  onTap: ()
                                  {
                                    //pop drawer
                                    Navigator.pop(context);

                                    //LogOut
                                    logout();

                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthPage()));
                                  },
                                ),
                              ),
                            ],
            );
          },         
        ),             
      );  
    }
}