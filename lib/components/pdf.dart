import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<String> generateInvoicePDF(Map<String, dynamic>? jobData) async {
  // Create a new PDF document
  final pdf = pw.Document();

  // Add page to the PDF
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Header
            pw.Text(
              'INVOICE',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20),

            // Company Info (you can customize this)
            pw.Text('Crane Services Inc.'),
            pw.Text('123 Business Street'),
            pw.Text('Johor Bahru, Malaysia'),
            pw.SizedBox(height: 20),

            // Invoice Details
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Invoice Number: ${jobData?['workOrderNo']}'),
                    pw.Text('Date: ${DateTime.now().toString().split(' ')[0]}'),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Operator: ${jobData?['operator']}'),
                    pw.Text('Location: ${jobData?['location']}'),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 30),

            // Service Table
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                // Table Header
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text('Service Description',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text('Cost',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                  ],
                ),
                // Table Row
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text(
                          'Crane Service - ${jobData?['weight']} - ${jobData?['vehicle']}'),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Text('${jobData?['price']}'),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),

            // Total
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      'Total: ${jobData?['price']}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 30),

            // Footer
            pw.Text('Payment Terms: Due within 30 days'),
            pw.Text('Thank you for your business!'),
          ],
        );
      },
    ),
  );

  // Save the PDF file
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/invoice_${jobData?['workOrderNo']}.pdf');
  await file.writeAsBytes(await pdf.save());

  return file.path;
  // Optionally, you can open the PDF file using a PDF viewer
  // You'll need to add appropriate dependencies for this
}

Future<void> sharePDF(String filePath) async {
  File file = File(filePath);

  if (await file.exists()) {
    Share.shareXFiles([XFile(filePath)], text: "Here's the invoice PDF.");
  } else {
    print("File not found");
  }
}