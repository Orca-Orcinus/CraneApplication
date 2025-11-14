import 'package:craneapplication/auth/AuthPage.dart';
import 'package:craneapplication/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://ajdkvfddcqswopamqauz.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFqZGt2ZmRkY3Fzd29wYW1xYXV6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk0NTg4OTUsImV4cCI6MjA1NTAzNDg5NX0.ItziwgzFEqnJocEfGKKtw8lwjpzszG-N4hQMCB7BEnc',
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [
    SystemUiOverlay.top,  // Status bar stays visible
    SystemUiOverlay.bottom,  // Navigation bar stays visible
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme: AppTheme.lightTheme,
      home: const AuthPage(),
    );
  }
}