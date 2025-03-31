import 'package:craneapplication/Pages/LoginPage.dart';
import 'package:craneapplication/helper/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/MyButton.dart';

class RegisterPage extends StatefulWidget {
  //final void Function()? onTap; // onTap callback to handle button press

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final confirmController = TextEditingController();

  void registerUserInformation(BuildContext context) async
  {
      showDialog(context: context,
      builder: (context)=> const Center(
        child: CircularProgressIndicator(),
        ),
      );

      if(pwController.text != confirmController.text)
      {
        //pop loading circle
        Navigator.pop(context);

        //show error message to user
        displayMessageToUser("Password doesn't match", context);
      }
      else
      {
        try
        {
          //Create User
          UserCredential? userCredential = 
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text
          , password: pwController.text);
          
          //pop loading circle
          Navigator.pop(context);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
        on FirebaseAuthException catch (e)
        {
          //pop loading circle
          Navigator.pop(context);

          //Display Error Message To User
          displayMessageToUser(e.code, context);
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: const Text("Register Page"),
          elevation: 0,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                
                const Text(
                  "Create an Account",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),

                // Email TextField
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Password TextField
                TextField(
                  controller: pwController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),

                // Confirm Password TextField
                TextField(
                  controller: confirmController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),

                const SizedBox(height: 32),

                MyButton(btnName: "Register User", onClick: () => registerUserInformation(context)),

                const SizedBox(height: 32),
                
                // Already have an account link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Go back to the login screen
                      },
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
