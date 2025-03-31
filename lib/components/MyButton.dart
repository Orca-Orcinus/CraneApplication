import 'package:flutter/material.dart';

class MyButton extends StatelessWidget
{
  final String btnName;
  final Function()? onClick;

  const MyButton({
    super.key,
    required this.btnName,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: onClick,      
      child:Container(
        padding: const EdgeInsets.all(25.0),
        margin: const EdgeInsets.symmetric(horizontal : 25.0),
        decoration: BoxDecoration(
          color:Colors.black,
          borderRadius: BorderRadius.circular(8.0),
          ),
        child:Center(
          child:Text(btnName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            ),
          ),
        ),
      )
    );
  }
}