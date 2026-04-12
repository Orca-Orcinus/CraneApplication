import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as gauth;
import 'package:http/http.dart' as http;
import 'package:excel/excel.dart';

class GoogleDriveReaderService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // ✅ Generate file name based on today e.g. "WEEK 1 APR 2026"
  String getThisWeekFileName() {
    final now = DateTime.now();
    final weekOfMonth = _getWeekOfMonth(now);
    final month = _monthName(now.month);
    final year = now.year;
    return 'WEEK $weekOfMonth $month $year';
  }

  // ✅ Calculate week of month (1st week, 2nd week, etc.)
  int _getWeekOfMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final dayOfMonth = date.day;
    return ((dayOfMonth + firstDayOfMonth.weekday - 2) / 7).floor() + 1;
  }

  String _monthName(int month) {
    const months = [
      'JAN','FEB','MAR','APR','MAY','JUN',
      'JUL','AUG','SEP','OCT','NOV','DEC'
    ];
    return months[month - 1];
  }

  // ✅ Format today's tab name e.g. "8-APR-2026"
  String getTodayTabName() {
    final now = DateTime.now();
    return '${now.day}-${_monthName(now.month)}-${now.year}';
  }

Future<drive.DriveApi?> _getDriveApi() async {
  try {
      // ✅ On web — don't call authenticate() again
      // Reuse existing session via authorizationClient directly
      final GoogleSignInClientAuthorization authorization = await _googleSignIn
          .authorizationClient
          .authorizeScopes([drive.DriveApi.driveReadonlyScope]);

      if (authorization == null) {
        print('Drive authorization failed — user may not be signed in');
        return null;
      }

      print('Drive authorization successful');

      // ✅ Build authenticated HTTP client using access token
      final authClient = gauth.authenticatedClient(
        http.Client(),
        gauth.AccessCredentials(
          gauth.AccessToken(
            'Bearer',
            authorization.accessToken,
            DateTime.now().toUtc().add(const Duration(hours: 1)),
          ),
          null,
          [drive.DriveApi.driveReadonlyScope],
        ),
      );

      return drive.DriveApi(authClient);

    } on GoogleSignInException catch (e) {
      print('Google Sign In error: ${e.code.name} ${e.description}');
      return null;
    } catch (e) {
      print('Drive API error: $e');
      return null;
    }
  }

  // ✅ Search Drive for this week's file by name
  Future<String?> findThisWeekFileId(drive.DriveApi driveApi) async {
    final fileName = getThisWeekFileName();
    print('Searching for file: $fileName');

    try {
      // Search across all files shared with user
      final result = await driveApi.files.list(
        q: "name = '$fileName' and mimeType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' and trashed = false",
        spaces: 'drive',
        $fields: 'files(id, name, parents)',
        includeItemsFromAllDrives: true,
        supportsAllDrives: true,
      );

      if (result.files == null || result.files!.isEmpty) {
        print('File not found: $fileName');
        return null;
      }

      final file = result.files!.first;
      print('Found file: ${file.name} (ID: ${file.id})');
      return file.id;

    } catch (e) {
      print('Error searching for file: $e');
      return null;
    }
  }

  // ✅ Main method — find file, read today's tab, filter by username
  Future<List<List<Data?>>?> readTodaySheet(String username) async {
    try {
      final driveApi = await _getDriveApi();
      if (driveApi == null) return null;

      // Step 1 — Find this week's file
      final fileId = await findThisWeekFileId(driveApi);
      if (fileId == null) return null;

      // Step 2 — Download the file
      print('Downloading file ID: $fileId');
      final drive.Media response = await driveApi.files.get(
        fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
        $fields: '*',
      ) as drive.Media;

      final List<int> bytes = [];
      await for (final chunk in response.stream) {
        bytes.addAll(chunk);
      }
      print('Downloaded ${bytes.length} bytes');

      // Step 3 — Find today's tab
      final excel = Excel.decodeBytes(bytes);
      final todayTab = getTodayTabName();

      print('Looking for tab: $todayTab');
      print('Available tabs: ${excel.tables.keys.toList()}');

      if (!excel.tables.containsKey(todayTab)) {
        print('No tab found for today: $todayTab');
        return null;
      }

      // Step 4 — Filter rows by username (second column)
      final rows = excel.tables[todayTab]!.rows;
      if (rows.isEmpty) return [];

      final headers = rows.first;
      final filteredRows = rows.skip(1).where((row) {
        if (row.length < 3) return false;
        final nameCell = row[2]?.value?.toString().trim() ?? '';
        return nameCell.toLowerCase() == username.toLowerCase();
      }).toList();

      print('Found ${filteredRows.length} rows for: $username');
      return [headers, ...filteredRows];

    } catch (e) {
      print('Error reading today sheet: $e');
      return null;
    }
  }

  // ✅ View all rows — no username filter, for testing only
Future<List<List<Data?>>?> readTodaySheetAll() async {
  try {
    final driveApi = await _getDriveApi();
    if (driveApi == null) return null;

    final fileId = await findThisWeekFileId(driveApi);
    if (fileId == null) return null;

    final drive.Media response = await driveApi.files.get(
      fileId,
      downloadOptions: drive.DownloadOptions.fullMedia,
      $fields: '*',
    ) as drive.Media;

    final List<int> bytes = [];
    await for (final chunk in response.stream) {
      bytes.addAll(chunk);
    }

    final excel = Excel.decodeBytes(bytes);
    final todayTab = getTodayTabName();

    print('Looking for tab: $todayTab');
    print('Available tabs: ${excel.tables.keys.toList()}');

    if (!excel.tables.containsKey(todayTab)) {
      print('No tab found for today: $todayTab');
      return null;
    }

    final rows = excel.tables[todayTab]!.rows;
    print('Total rows (no filter): ${rows.length}');
    return rows;

    } catch (e) {
      print('Error reading all rows: $e');
      return null;
    }
  }
}