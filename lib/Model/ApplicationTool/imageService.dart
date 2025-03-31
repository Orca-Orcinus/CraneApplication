import 'package:craneapplication/features/auth/fbStorage.dart';
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
}

class ImageService
{
  final ImagePicker _picker = ImagePicker();  
  final FBStorage fbStorageTool = FBStorage();
  Map<String,Map<documentType,List<File>>> jobImages = {};
  String _base64Image = "";

  Future<void> pickImage(String imageId,documentType documentType) async
  {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null)
    {
      // Initialize the nested map and list if they don't exist
      jobImages.putIfAbsent(imageId, () => {});
      jobImages[imageId]!.putIfAbsent(documentType, () => []);
      // Add the new image to the list
      jobImages[imageId]![documentType]!.add(File(image.path));      
      fbStorageTool.uploadJobImage(imageId, documentType, File(image.path));
    }
  }

  Future<void> takePicture(String pictureId,documentType documentType) async
  {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if(image != null)
    {
      // Initialize the nested map and list if they don't exist
      jobImages.putIfAbsent(pictureId, () => {});
      jobImages[pictureId]!.putIfAbsent(documentType, () => []);
      // Add the new image to the list
      jobImages[pictureId]![documentType]!.add(File(image.path));     
      fbStorageTool.uploadJobImage(pictureId, documentType, File(image.path));
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
          image.path + '_compressed.jpg',
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

    if (_base64Image == null) {
      print('No image to share.');
      return;
    }

    // Share the Base64 image as text
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
}