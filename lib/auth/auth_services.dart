import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  //google sign in
  signInWithGoogle() async
  {
    try{
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      //obtain auth detail from request
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      //create a new user credential
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      //finally, lets sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    catch(e)
    {
      print("Error during Google Sign-In. $e");
    }
  }
}