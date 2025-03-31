// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craneapplication/enum/RolesEnum.dart';
import 'package:craneapplication/features/auth/firebasestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile
{
  final FirebaseAuth authInstance = FirebaseAuth.instance;
  final FireStoreService _dbService = FireStoreService();
  String loggedInUser = "";

  Future<String> checkExistingUser() async
  {
    try{
      final User? user = authInstance.currentUser;
      if(user != null)
      {
        loggedInUser = user.displayName ?? "Unknown User";
        return loggedInUser;
      }
      else
      {
        return "Unknown User";
      }
    }
    catch(e)
    {
      print("Error checking existing user: $e");
      return "Unknown User";
    }
  }

  Future<Map<String,dynamic>?> getUserData(String userCollection) async
  {
    try{
      final User? user = authInstance.currentUser;

      List<Map<String,dynamic>> operatorData = 
        await _dbService.getData(collection: userCollection);

      final filteredData = operatorData.firstWhere(
          (doc) => doc['emailAddress'] == user?.email); 

      return filteredData.isNotEmpty ? filteredData : null;
    }
    catch(e)
    {
      print("Error fetching user data $e");
      return null;
    }
  }

  Future<Map<String,dynamic>?> createAndgetUserData(String userCollection) async
  {
    try
    {
      final Map<String,dynamic>? isUserExist = await getUserData(userCollection);

      if(isUserExist != null)
      {
        return isUserExist;
      }

      final User? user = authInstance.currentUser;

      if(user == null) return null;

      DocumentReference userDocRef = FirebaseFirestore.instance.collection(userCollection).doc(user.uid);
      DocumentSnapshot userSnapshot = await userDocRef.get();

      if(!userSnapshot.exists)
      {        
        await userDocRef.set(
         {
            "uid": user.uid,
            "name": loggedInUser,
            "emailAddress": user.email,
            "roles":Rolesenum.None.toString(),            
         });
         return (await userDocRef.get()).data() as Map<String, dynamic>?;
      }      
      return (await getUserData(userCollection));
    }
    catch(e)
    {
      print("Unable to create the following user. $e");
      return null;
    }
  }
}