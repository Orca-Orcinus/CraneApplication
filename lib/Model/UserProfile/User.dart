import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';

class UserInformation
{
  final String name;
  final Encrypted password;
  final int mobileNumber;
  final String emailAddress;

  UserInformation({required this.name, required this.password,required this.mobileNumber,required this.emailAddress});
}


class User extends StatelessWidget
{
  const User({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Container(

    );
  }
}