
import 'package:craneapplication/components/GoogleDriveService.dart';
import 'package:craneapplication/features/auth/fbStorage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:share_plus/share_plus.dart';

enum documentType
{
  workOrder,
  onSiteArrival,
  deliveryOrder,
}

class ImageService
{
  final ImagePicker _picker = ImagePicker();  
  final FBStorage fbStorageTool = FBStorage();
  final GoogleDriveService _driveService = GoogleDriveService();
  Map<String,Map<documentType,List<File>>> jobImages = {};
  String _base64Image = "";

  Future<void> pickImage(String imageId,documentType documentType) async
  {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null)
    {
      if (kIsWeb) {
        // 🌐 Web — use bytes directly, no File/Platform
        print('Running on Web');
        final Uint8List bytes = await image.readAsBytes();
        await fbStorageTool.uploadJobImageBytes(imageId, documentType, bytes); // Disable Supabase for the moment
        // await _driveService.uploadImage(bytes, '$imageId.jpg');
      } else {
        // 📱 Android — use File from dart:io
        print('Running on Android');
        final File file = File(image.path);
        await fbStorageTool.uploadJobImage(imageId, documentType, file);// Disable Supabase for the moment
        // await _driveService.uploadImage(await file.readAsBytes(), '$imageId.jpg');
      }
    }
  }

  Future<void> takePicture(String pictureId,documentType documentType) async
  {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if(image != null)
    {
      if (kIsWeb) {
        // 🌐 Web — use bytes directly, no File/Platform
        print('Running on Web');
        final Uint8List bytes = await image.readAsBytes();
        await fbStorageTool.uploadJobImageBytes(pictureId, documentType, bytes); // Disable Supabase for the moment
        //await _driveService.uploadImage(bytes, '$pictureId.jpg');
      } else {
          // 📱 Android — use File from dart:io
          print('Running on Android');
          final File file = File(image.path);
          await fbStorageTool.uploadJobImage(pictureId, documentType, file);// Disable Supabase for the moment
          //await _driveService.uploadImage(await file.readAsBytes(), '$pictureId.jpg');      
      }
    }
  }

  Future<void> takebase64Picture(String pictureId,documentType documentType) async {
    try {
      // Capture the image
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if(image != null)
      {
        final compressedFile = await FlutterImageCompress.compressAndGetFile(
          image.path,
          '${image.path}_compressed.jpg',
          quality: 50, // Adjust quality as needed
        );
        
        if (compressedFile != null) {
          // Read the compressed file as bytes
          final bytes = await compressedFile.readAsBytes();

          // Convert the bytes to Base64
          _base64Image = base64Encode(bytes);

          // Optionally, upload the Base64 string to Firebase or other storage
          fbStorageTool.uploadJobImage(pictureId, documentType, File(_base64Image));
        }
      }
      // Compress the image

    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> shareBase64Image() async {

    await Share.share('Check out this image: data:image/jpeg;base64,$_base64Image');
  }

  Future<Image?> decodeBase64Image(String base64String) async
  {
    try
    {
      // Decode the Base64 string into bytes
      final bytes = base64Decode(base64String);

      // Return the decoded image
      return Image.memory(bytes);
    }
    catch(e)
    {
      print('Error decoding Base64 image: $e');
      return null;
    }
  }

  Future<void> inputWorkOrderNo(String jobId,documentType documentType,String workOrderNo) async
  {
    fbStorageTool.uploadWorkOrderNo(jobId, documentType, workOrderNo);
  }  

  Future<void> inputDeliveryOrderNo(String jobId,documentType documentType,String deliveryOrderNo) async
  {
    fbStorageTool.uploadWorkOrderNo(jobId, documentType, deliveryOrderNo);
  }
}