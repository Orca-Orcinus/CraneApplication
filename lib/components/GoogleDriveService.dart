import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';

class GoogleDriveService {
  // 🔁 Replace with your actual shared folder ID
  // Get it from the URL: drive.google.com/drive/folders/THIS_PART
  static const String _sharedFolderId = '1hOwnpJvWHYwZXLUoJiPRosg9RfPfHKYy';

  Future<drive.DriveApi> _getDriveApi() async {
    // Load service account credentials from assets
    final jsonString = await rootBundle.loadString('assets/service_account.json');
    final credentials = ServiceAccountCredentials.fromJson(jsonDecode(jsonString));

    final scopes = [drive.DriveApi.driveScope];
    final authClient = await clientViaServiceAccount(credentials, scopes);
    return drive.DriveApi(authClient);
  }

  // Upload image bytes to Google Drive
  Future<String?> uploadImage(Uint8List imageBytes, String fileName) async {
    try {
      final driveApi = await _getDriveApi();

      // Set file metadata
      final driveFile = drive.File()
        ..name = fileName
        ..parents = [_sharedFolderId]; // ✅ Upload to shared folder

      // Upload the file
      final response = await driveApi.files.create(
        driveFile,
        uploadMedia: drive.Media(
          Stream.fromIterable([imageBytes]),
          imageBytes.length,
          contentType: 'image/jpeg',
        ),
        supportsAllDrives: true,        // ✅ Add this
      );

      print('Uploaded to Drive. File ID: ${response.id}');
            // ✅ Make file readable by anyone with the link
      await driveApi.permissions.create(
        drive.Permission()
          ..role = 'reader'
          ..type = 'anyone',
        response.id!,
        supportsAllDrives: true,        // ✅ Add this
      );

      // Return shareable link
      final fileId = response.id;
      return 'https://drive.google.com/file/d/$fileId/view';

    } catch (e) {
      print('Google Drive upload error: $e');
      return null;
    }
  }
}