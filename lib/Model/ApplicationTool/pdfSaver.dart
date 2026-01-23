import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class PdfSaver{
  static Future<void> savePdf(Uint8List bytes, String fileName) async {
    if (kIsWeb) {
      // 🌐 WEB: Browser download dialog
      await Printing.sharePdf(bytes: bytes, filename: fileName);
    } else {
      // 📱 ANDROID: Save locally
      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/$fileName");

      await file.writeAsBytes(bytes);

      debugPrint("PDF saved to: ${file.path}");
    }
  }
  }


