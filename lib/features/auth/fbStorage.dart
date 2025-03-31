import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craneapplication/Model/ApplicationTool/imageService.dart';
import 'package:craneapplication/features/auth/firebasestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FBStorage {
  final FireStoreService fsService = FireStoreService();
  String publicUrl = '';

  // Authenticate the user once (e.g., during app startup)
  Future<void> authenticateUser() async {
    try {
      final authResponse = await Supabase.instance.client.auth.signInWithPassword(
        email: 'manager@gmail.com',
        password: 'managertest',
      );

      if (authResponse.user == null) {
        print('Authentication failed');
        throw Exception('Authentication failed');
      }
    } catch (e) {
      print('Error authenticating user: $e');
      rethrow;
    }
  }

  Future<void> uploadWorkOrderNo(String jobId,documentType documentType,String workOrderNumber) async
  {
      // // Retrieve the Firestore document ID
      String? documentId = await getJobDocumentId(collection: "JobInfo", jobId: jobId);

      if (documentId != null) {
        // Update the Firestore document with the image URL
        await fsService.updateData(
          collection: "JobInfo",
          documentId: documentId,
          data: {
            "workOrderNo": workOrderNumber,
          },
        );
      } else {
        print('Document ID not found for jobId: $jobId');
      }
  }

  Future<String?> getWorkOrderData(String jobId) async
  {
      // // Retrieve the Firestore document ID
      String? documentId = await getJobDocumentId(collection: "JobInfo", jobId: jobId);

      return documentId;
  }

  Future<void> uploadJobImage(String taskId, documentType documentType, File imageFile) async {
    try {
      // Ensure the user is authenticated
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        await authenticateUser();
      }

      // Generate a unique file name
      String fileName = "${documentType.toString()}_${DateTime.now().millisecondsSinceEpoch}.jpg";

      // Upload the image to Supabase Storage
      // await Supabase.instance.client.storage
      //     .from('craneapplication')
      //     .upload(fileName, imageFile);

      // // Get the public URL of the uploaded image
      // publicUrl = Supabase.instance.client.storage
      //     .from('craneapplication')
      //     .getPublicUrl(fileName);

      // // // Retrieve the Firestore document ID
      String? documentId = await getJobDocumentId(collection: "JobInfo", jobId: taskId);

      if (documentId != null) {
        // Update the Firestore document with the image URL
        await fsService.updateData(
          collection: "JobInfo",
          documentId: documentId,
          data: {
            "${documentType.toString().toLowerCase()}_images": fileName,
          },
        );
      } else {
        print('Document ID not found for jobId: $taskId');
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  Future<String?> getJobDocumentId({
    required String collection,
    required String jobId,
  }) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
        .collection(collection)
        .where('id', isEqualTo: jobId) // Query by jobId
        .limit(1) // Limit to one result
        .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id; // Return document ID
      }
      return null; // Return null if no match is found
    } catch (e) {
      print('Error retrieving document ID: $e');
      rethrow;
    }
  }
}