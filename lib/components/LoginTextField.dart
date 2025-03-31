import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget
{
  final controller;
  final String hintText;
  final bool obscureText;


  const LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    });
  
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child:
        TextFormField(
          controller:controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color:Colors.blue),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: hintText,             
              hintStyle: TextStyle(
                color: Colors.grey.shade500                
                ) 
          ),
        ),
    );
  }
}