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
    url: 'https://xqbansqywmrybfpiffhd.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhxYmFuc3F5d21yeWJmcGlmZmhkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzU0NjMzNDIsImV4cCI6MjA5MTAzOTM0Mn0.WmB_Rwdtf4huwFPSn5iiAn28rkEfu2c8SaeLpW8GK4E',
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