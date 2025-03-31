import 'package:craneapplication/enum/RolesEnum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthServices
{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseStore = FirebaseFirestore.instance;

  Future<String?> registerWithEmailOrUsername({
    required String? email,
    required String? username,
    required String? password,
  }) async
  {
    try
    {
      final usernameQuery = await firebaseStore.collection('users')
      .where('username',isEqualTo: username).get();

      if(usernameQuery.docs.isNotEmpty)
      {
        return "Username already exists";
      }

      final UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
          email:email.toString(),
          password: password.toString(),
        );

      await firebaseStore.collection('users').doc(userCredential.user!.uid).set({
        'uid':userCredential.user!.uid,
        'email':email,
        'username':username,
        'roles': Rolesenum.None.toString(),
      });
    }
    on FirebaseException catch(e)
    {
      return e.message;
    }
    return null;
  } 

  Future<String?> loginWithEmailOrPassword({
    required String emailOrUsername,
    required String password,
  }) async
  {
    try{
      String loginDetails = emailOrUsername;

      if(!loginDetails.contains('@'))
      {
        final UsernameQuery = await firebaseStore
          .collection('users')
          .where('username',isEqualTo: loginDetails).get();

        if(UsernameQuery.docs.isEmpty)
        {
          return "Username not found!";
        }

        loginDetails = UsernameQuery.docs.first['email'];
      }

      await _auth.signInWithEmailAndPassword(
        email: loginDetails,
        password: password,
      );
    }
    on FirebaseException catch (e)
    {
      return e.message;
    }
    return null;
  }

  User? getCurrentUser()
  {
    return _auth.currentUser;
  }

  Future<void> signOut()async{
    _auth.signOut();
  }
}