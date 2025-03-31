import 'package:craneapplication/themes/theme.dart';
import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final GestureTapCallback? onTap;
  const SquareTile({super.key,required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:Container(
        decoration: BoxDecoration(border: Border.all(color: AppTheme.lightTheme.scaffoldBackgroundColor,)
        ,borderRadius: BorderRadius.circular(8.0), color:  AppTheme.lightTheme.scaffoldBackgroundColor),
        child: Image.asset(
          imagePath,
          height: 50,
        ),
      ),
    );
  }
}