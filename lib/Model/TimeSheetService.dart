import 'dart:js_interop';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:craneapplication/Model/UserProfile/userService.dart';
import 'package:craneapplication/features/auth/firebasestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;
import 'TimeSheetModel.dart';
import 'package:intl/intl.dart';

class TimesheetService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserService _userService = UserService();
  final FireStoreService fsService = FireStoreService();

  // ✅ Collection path: timesheets/{LUCAS_FEB_2026}/entries/{docId}
  String _getCollectionPath(String operatorName, DateTime date) {
    final month = DateFormat('MMM').format(date).toUpperCase();
    final year = date.year;
    final name = operatorName.toUpperCase().replaceAll(' ', '_');
    return 'timesheets/${name}_${month}_$year/entries';
  }

  // ✅ Save entry to Firestore
  Future<void> saveEntry(TimesheetEntry entry) async {
    try {
      final path = _getCollectionPath(entry.operatorName, entry.date);
      await _firestore.collection(path).add(entry.toFirestore());
      print('Entry saved to Firestore: $path');
    } catch (e) {
      print('Error saving entry: $e');
      rethrow;
    }
  }

  // ✅ Get all entries for an operator for a given month
  Future<List<TimesheetEntry>> getEntriesForMonth(
    String operatorName,
    DateTime month,
  ) async {
    try {
      final path = _getCollectionPath(operatorName, month);
      final snapshot = await _firestore
          .collection(path)
          .orderBy('date')
          .get();

      return snapshot.docs
          .map((doc) => TimesheetEntry.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Error fetching entries: $e');
      return [];
    }
  }

  // ✅ Stream entries for current month (live updates)
  Stream<List<TimesheetEntry>> streamEntriesForMonth(
    String operatorName,
    DateTime month,
  ) {
    final path = _getCollectionPath(operatorName, month);
    return _firestore
        .collection(path)
        .orderBy('date')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TimesheetEntry.fromFirestore(doc.data(), doc.id))
            .toList());
  }

  // ✅ Delete entry from Firestore
  Future<void> deleteEntry(String operatorName, DateTime date, String docId) async {
    try {
      final path = _getCollectionPath(operatorName, date);
      await _firestore.collection(path).doc(docId).delete();
      print('Entry deleted from Firestore: $path/$docId');
    } catch (e) {
      print('Error deleting entry: $e');
      rethrow;
    }
  }

  // ✅ Generate Excel file name e.g. LUCAS_FEB_2026
  String getExcelFileName(String operatorName, DateTime month) {
    final monthStr = DateFormat('MMM').format(month).toUpperCase();
    final name = operatorName.toUpperCase().replaceAll(' ', '_');
    return '${name}_${monthStr}_${month.year}.xlsx';
  }

  // ✅ Generate and download Excel file
  Future<void> generateAndDownloadExcel(
    String operatorName,
    DateTime month,
  ) async {
    final entries = await getEntriesForMonth(operatorName, month);
    final fileName = getExcelFileName(operatorName, month);

    // Create Excel
    final excel = Excel.createExcel();
    final sheetName = '${DateFormat('MMM').format(month).toUpperCase()}_${month.year}';
    final sheet = excel[sheetName];
    excel.delete('Sheet1'); // remove default sheet

    // ── Header row ────────────────────────────────────────
    final headers = [
      'Date',
      'Operator Name',
      'Car Plate',
      'Customer',
      'Location',
      'Ton',
      'Working Hours',
      'Total Hours',
      'Overtime Hours',
    ];

    for (int i = 0; i < headers.length; i++) {
      final cell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0),
      );
      cell.value = TextCellValue(headers[i]);
      cell.cellStyle = CellStyle(
        bold: true,
        backgroundColorHex: ExcelColor.fromHexString('#1565C0'),
        fontColorHex: ExcelColor.fromHexString('#FFFFFF'),
        horizontalAlign: HorizontalAlign.Center,
      );
    }

    // ── Data rows ─────────────────────────────────────────
    for (int i = 0; i < entries.length; i++) {
      final entry = entries[i];
      final rowIndex = i + 1;
      final isEven = i.isEven;
      final bgColor = isEven
          ? ExcelColor.fromHexString('#FFFFFF')
          : ExcelColor.fromHexString('#E3F2FD');

      final rowData = [
        DateFormat('dd/MM/yyyy').format(entry.date),
        entry.operatorName,
        entry.carPlate,
        entry.customer,
        entry.location,
        entry.ton.toString(),
        entry.workingHoursDisplay,
        entry.workingHours.toStringAsFixed(2),
        entry.overtimeHours.toStringAsFixed(2),
      ];

      for (int j = 0; j < rowData.length; j++) {
        final cell = sheet.cell(
          CellIndex.indexByColumnRow(columnIndex: j, rowIndex: rowIndex),
        );
        cell.value = TextCellValue(rowData[j]);
        cell.cellStyle = CellStyle(
          backgroundColorHex: bgColor,
        );
      }
    }

    // ── Summary row ───────────────────────────────────────
    final summaryRow = entries.length + 2;
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: summaryRow)).value =
        TextCellValue('TOTAL');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: summaryRow)).value =
        TextCellValue(entries.fold(0.0, (sum, e) => sum + e.ton).toStringAsFixed(2));
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: summaryRow)).value =
        TextCellValue(entries.fold(0.0, (sum, e) => sum + e.workingHours).toStringAsFixed(2));
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: summaryRow)).value =
        TextCellValue(entries.fold(0.0, (sum, e) => sum + e.overtimeHours).toStringAsFixed(2));

    // ── Set column widths ──────────────────────────────────
    sheet.setColumnWidth(0, 15); // Date
    sheet.setColumnWidth(1, 20); // Operator
    sheet.setColumnWidth(2, 15); // Car Plate
    sheet.setColumnWidth(3, 20); // Customer
    sheet.setColumnWidth(4, 20); // Location
    sheet.setColumnWidth(5, 10); // Ton
    sheet.setColumnWidth(6, 20); // Working Hours
    sheet.setColumnWidth(7, 15); // Total Hours
    sheet.setColumnWidth(8, 15); // Overtime

    // ── Download ──────────────────────────────────────────
    final bytes = Uint8List.fromList(excel.encode()!);
    _downloadFile(bytes, fileName);
    print('Downloaded: $fileName');
  }

  // ✅ Web file download
void _downloadFile(Uint8List bytes, String fileName) {
  if (kIsWeb) {
    // ✅ Convert Uint8List to JS-compatible format
    final jsArray = bytes.toJS;
    final blob = web.Blob(
      [jsArray].toJS,
      web.BlobPropertyBag(type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
    );

    final url = web.URL.createObjectURL(blob);

    final anchor = web.document.createElement('a') as web.HTMLAnchorElement
      ..href = url
      ..setAttribute('download', fileName)
      ..click();

    web.URL.revokeObjectURL(url);
    print('Downloaded: $fileName');
  }
}

  // ✅ Get all unique operator names from Firestore
  Future<List<String>> getAllOperators() async {
    try {
      List<Map<String, dynamic>?> allUserData = await fsService.getData(collection: "userDetails").then((value) => value.whereType<Map<String, dynamic>>().toList());
      final operators = allUserData
          .whereType<Map<String, dynamic>>()
          .where((user) => user['roles'] == 'Rolesenum.Operator')
          .map((user) => user['name'] as String)
          .toSet()
          .toList();
      return operators;

    } catch (e) {
      print('Error fetching operators: $e');
      return [];
    }
  }
}