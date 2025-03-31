import 'package:craneapplication/Pages/HomePage.dart';
import 'package:craneapplication/Pages/RegisterPage.dart';
import 'package:craneapplication/auth/auth_services.dart';
import 'package:craneapplication/components/MyButton.dart';
import 'package:craneapplication/helper/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget
{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

void registerNewUser(BuildContext context)
{
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const RegisterPage())
  );
}

class _LoginPageState extends State<LoginPage>
{  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn (BuildContext context) async
  {
    showDialog(
      context: context, 
      builder: (context) => const Center(
        child: CircularProgressIndicator(),));


    //try to sign in
    try
    {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text);
      
      //pop loading circle 
      if(context.mounted) {
        Navigator.pop(context);
      }

      // Navigate to CraneSelectionPage
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    }
    on FirebaseAuthException catch (e)
    {
      Navigator.pop(context);

      if(e.code == 'user-not-found')
      {
        displayMessageToUser("User Not Found!", context);
      }
      else if(e.code == "wrong-password")
      {
        displayMessageToUser("Incorrect password.", context);
      }
      else
      {
        displayMessageToUser(e.code, context);
      }
    }
}

  @override
    Widget build(BuildContext context)
    {
      return Scaffold(      
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
          child : AppBar(          
            title: const Text("Home Page"),
            elevation: 0,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Padding(           
                  padding: const EdgeInsets.all(0),           
                  child: Image.asset('assets/images/CraneService.png'),           
                ),
                
                const SizedBox(height :30),

                const Text(
                  'Welcome',
                  style: TextStyle(
                    color:Colors.black,
                    fontSize: 32)
                ),

                const SizedBox(height : 10),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: false,
                        ),

                      SizedBox(height : 10),

                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),                  
                        obscureText: true,
                      ),                     
                    ],              
                  ),
                ),


                const SizedBox(height:10),

                //Forgot Password
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color:Color.fromARGB(190, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                ),

                const SizedBox(height:10),

                MyButton(btnName: "Sign In", onClick: () => signUserIn(context)),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade400,
                          thickness: 0.5,
                        ),
                      ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text("Or Continue With"),
                      ),
                        Expanded(
                        child: Divider(
                          color: Colors.grey.shade400,
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                //google icon and referencing
                Padding(padding: const EdgeInsets.symmetric(horizontal: 25),
                child:      
                      TextButton.icon(onPressed: () {
                      AuthServices().signInWithGoogle();
                    },
                        icon: Image.asset('assets/images/google.png', height:24.0, width: 24),
                        label: Text("Login With Google",style: TextStyle(fontSize: 16,color: Colors.black
                      ),
                    ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(12),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),

                const SizedBox(height:20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not A Member?"),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => registerNewUser(context),
                      child: const Text(
                          "Register Now!",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ), 
                  ],
                ),
            ]),
          ),
        ),
      ),
    );
  }
}