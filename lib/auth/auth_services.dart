import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {  
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;      
  bool _isGoogleSignInitialized = false;

  AuthServices()
  {
    _initializeGoogleSignIn();
  }

  Future<void> _initializeGoogleSignIn() async {
    try{
      await _googleSignIn.initialize();
      _isGoogleSignInitialized = true;
    }
    catch(e)
    {
      print("Failed to initialize Google Sign-In: $e");
    }
  }

  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInitialized) {
      await _initializeGoogleSignIn();
    }
  } 

  Future<UserCredential?> signInWithGoogle() async
  {
    await _ensureGoogleSignInInitialized();
    try {
      final GoogleSignInAccount? gUser = await _googleSignIn.authenticate();
      final GoogleSignInClientAuthorization? authorization = await gUser?.authorizationClient.authorizationForScopes(['email']);
      
      final credential = GoogleAuthProvider.credential(
        idToken: gUser!.authentication.idToken,
        accessToken: authorization?.accessToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);

    } on GoogleSignInException catch (e) {
      print('Google Sign In error: code: ${e.code.name} description:${e.description} details:${e.details}');
    } catch (e) {
      print("Google Sign-In failed: $e");
    }
    return null;
  }
}