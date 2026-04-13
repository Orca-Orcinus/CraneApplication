import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class WatermarkService {
  // ✅ Pick image and add watermark with location + datetime
  Future<Uint8List?> pickImageWithWatermark({
    required ImageSource source,
    required String location,
    required DateTime dateTime,
    String carPlate = '',
  }) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (image == null) return null;

    final bytes = await image.readAsBytes();
    return await _addWatermark(
      imageBytes: bytes,
      location: location,
      dateTime: dateTime,
      carPlate: carPlate,
    );
  }

  // ✅ Draw watermark onto image using Flutter canvas
  Future<Uint8List?> _addWatermark({
    required Uint8List imageBytes,
    required String location,
    required DateTime dateTime,
    String operatorName = '',
    String carPlate = '',
  }) async {
    try {
      // Decode image
      final codec = await ui.instantiateImageCodec(imageBytes);
      final frame = await codec.getNextFrame();
      final image = frame.image;

      final width = image.width.toDouble();
      final height = image.height.toDouble();

      // Create canvas
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);

      // Draw original image
      canvas.drawImage(image, Offset.zero, Paint());

      // ── Watermark background ────────────────────────────────
      final bgPaint = Paint()
        ..color = Colors.black.withOpacity(0.55);
      final bgRect = Rect.fromLTWH(0, height - 120, width, 120);
      canvas.drawRect(bgRect, bgPaint);

      // ── Watermark text ──────────────────────────────────────
      final dateText = DateFormat('dd MMM yyyy  HH:mm:ss').format(dateTime);
      final locationText = '📍 $location';
      final operatorName = '👷‍♂️ Operator: {operatorName}';
      final carPlateText = '🚗 Car Plate: ${carPlate}';

      // Date/time text
      _drawText(
        canvas: canvas,
        text: dateText,
        x: 16,
        y: height - 105,
        fontSize: width * 0.030,
        color: Colors.white,
        bold: true,
      );

      // Location text
      _drawText(
        canvas: canvas,
        text: locationText,
        x: 16,
        y: height - 65,
        fontSize: width * 0.027,
        color: Colors.yellowAccent,
        bold: false,
      );

      // Operator Name watermark
      _drawText(
        canvas: canvas,
        text: operatorName,
        x: 16,
        y: height - 28,
        fontSize: width * 0.022,
        color: Colors.white60,
        bold: false,
      );

      // Car plate watermark
      _drawText(
        canvas: canvas,
        text: carPlateText,
        x: 16,
        y: height - 28,
        fontSize: width * 0.022,
        color: Colors.white60,
        bold: false,
      );

      // ── Render ──────────────────────────────────────────────
      final picture = recorder.endRecording();
      final renderedImage = await picture.toImage(
        image.width,
        image.height,
      );
      final byteData = await renderedImage.toByteData(
        format: ui.ImageByteFormat.png,
      );

      return byteData?.buffer.asUint8List();
    } catch (e) {
      print('Watermark error: $e');
      return null;
    }
  }

  void _drawText({
    required Canvas canvas,
    required String text,
    required double x,
    required double y,
    required double fontSize,
    required Color color,
    required bool bold,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize.clamp(12.0, 28.0),
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          shadows: const [
            Shadow(color: Colors.black, blurRadius: 4, offset: Offset(1, 1)),
          ],
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x, y));
  }
}