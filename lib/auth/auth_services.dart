import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;

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

  // ✅ Android — programmatic sign in
  Future<UserCredential?> signInWithGoogle() async {
    await _ensureGoogleSignInInitialized();
    try {
      final GoogleSignInAccount gUser = await _googleSignIn.authenticate();

    // ✅ Request both email AND Drive scope together at sign-in
      final GoogleSignInClientAuthorization? authorization = await gUser
          .authorizationClient
          .authorizationForScopes([
            'email',
            drive.DriveApi.driveReadonlyScope, // ✅ Add Drive scope here
          ]);

      final credential = GoogleAuthProvider.credential(
        idToken: gUser.authentication.idToken,
        accessToken: authorization?.accessToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);

    } on GoogleSignInException catch (e) {
      print('Google Sign In error: code: ${e.code.name} description: ${e.description}');
    } catch (e) {
      print('Google Sign-In failed: $e');
    }
    return null;
  }

  // ✅ Web — handle sign in from Google button callback
  Future<UserCredential?> handleWebSignIn(GoogleSignInAccount gUser) async {
    try {
      final GoogleSignInClientAuthorization? authorization = await gUser
          .authorizationClient
          .authorizationForScopes([
            'email',
            drive.DriveApi.driveReadonlyScope,
          ]);

      final credential = GoogleAuthProvider.credential(
        idToken: gUser.authentication.idToken,
        accessToken: authorization?.accessToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);

    } on GoogleSignInException catch (e) {
      print('Web Sign In error: ${e.code.name} ${e.description}');
    } catch (e) {
      print('Web Sign-In failed: $e');
    }
    return null;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}