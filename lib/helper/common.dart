import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Display Error Message to User
void displayMessageToUser(String message, BuildContext context)
{
  showDialog(context: context, 
  builder: (context) => AlertDialog(title: Text(message),)
  );
}

DateTime? parseDate(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is Timestamp) return value.toDate();
  if (value is String) {
    try {
      return DateTime.parse(value);
    } catch (_) {
      // try parsing as int string
      final intVal = int.tryParse(value);
      if (intVal != null) return DateTime.fromMillisecondsSinceEpoch(intVal);
      return null;
    }
  }
  if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
  return null;
}