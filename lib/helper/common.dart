import 'package:flutter/material.dart';

//Display Error Message to User
void displayMessageToUser(String message, BuildContext context)
{
  showDialog(context: context, 
  builder: (context) => AlertDialog(title: Text(message),)
  );
}