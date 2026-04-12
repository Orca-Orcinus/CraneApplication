import 'package:craneapplication/components/GoogleDriveReaderService.dart';
import 'package:craneapplication/components/MyDrawer.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';

class ExcelViewerPage extends StatefulWidget {
  final Future<String> username;

  const ExcelViewerPage({super.key, required this.username});

  @override
  State<ExcelViewerPage> createState() => _ExcelViewerPageState();
}

class _ExcelViewerPageState extends State<ExcelViewerPage> {
  final GoogleDriveReaderService _driveReader = GoogleDriveReaderService();

  List<List<Data?>>? _rows;
  bool _isLoading = false;
  String? _error;
  String? _fileName;
  String? _tabName;
  bool _isViewAll = false; // ✅ Track view mode

  @override
  void initState() {
    super.initState();
    _loadTodaySheet();
  }

  // ✅ Load filtered by username
  Future<void> _loadTodaySheet() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _rows = null;
      _isViewAll = false;
      _fileName = _driveReader.getThisWeekFileName();
      _tabName = _driveReader.getTodayTabName();
    });

    String username = await widget.username;

    final rows = await _driveReader.readTodaySheet(username);

    setState(() {
      _isLoading = false;
      if (rows == null) {
        _error = 'No schedule found.\n\nLooked for:\nFile: $_fileName\nTab: $_tabName\n\nMake sure the file has been shared with you.';
      } else if (rows.length <= 1) {
        _error = 'No entries found for "$username" today.\n\nFile: $_fileName\nTab: $_tabName';
      } else {
        _rows = rows;
      }
    });
  }

  // ✅ Load all rows — no filter
  Future<void> _loadAllRows() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _rows = null;
      _isViewAll = true;
      _fileName = _driveReader.getThisWeekFileName();
      _tabName = _driveReader.getTodayTabName();
    });

    final rows = await _driveReader.readTodaySheetAll();

    setState(() {
      _isLoading = false;
      if (rows == null) {
        _error = 'No schedule found.\n\nLooked for:\nFile: $_fileName\nTab: $_tabName';
      } else if (rows.isEmpty) {
        _error = 'Tab "$_tabName" is empty.';
      } else {
        _rows = rows;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Schedule',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (_fileName != null && _tabName != null)
              Text(
                '$_fileName  •  $_tabName',
                style: const TextStyle(fontSize: 11, color: Colors.white70),
              ),
          ],
        ),
        actions: [
          // ✅ View All toggle button
          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            icon: Icon(_isViewAll ? Icons.person : Icons.group),
            label: Text(
              _isViewAll ? 'My View' : 'View All',
              style: const TextStyle(fontSize: 12),
            ),
            onPressed: _isLoading
                ? null
                : () {
                    if (_isViewAll) {
                      _loadTodaySheet(); // Switch back to user filter
                    } else {
                      _loadAllRows();   // Switch to view all
                    }
                  },
          ),
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: _isLoading
                ? null
                : () => _isViewAll ? _loadAllRows() : _loadTodaySheet(),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // ── Loading ──────────────────────────────────────────────
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              _isViewAll
                  ? 'Loading all rows...\n${_fileName ?? ''}'
                  : 'Loading schedule...\n${_fileName ?? ''}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    // ── Error ────────────────────────────────────────────────
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.event_busy, size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 20),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                onPressed: _isViewAll ? _loadAllRows : _loadTodaySheet,
              ),
            ],
          ),
        ),
      );
    }

    // ── No data ──────────────────────────────────────────────
    if (_rows == null || _rows!.isEmpty) {
      return const Center(child: Text('No data available.'));
    }

    final headers = _rows!.first;
    final dataRows = _rows!.skip(1).toList();

    // ── Data ─────────────────────────────────────────────────
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        // ── Banner ───────────────────────────────────────────
        Container(
          color: _isViewAll ? Colors.orange.shade50 : Colors.blue.shade50,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Icon(
                _isViewAll ? Icons.group : Icons.person,
                size: 18,
                color: _isViewAll ? Colors.orange : Colors.blue,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _isViewAll
                      ? 'Viewing all entries (test mode)'
                      : 'Showing schedule for: ${widget.username}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _isViewAll ? Colors.orange : Colors.blue,
                  ),
                ),
              ),
              Text(
                '${dataRows.length} ${dataRows.length == 1 ? 'entry' : 'entries'}',
                style: TextStyle(
                  color: _isViewAll ? Colors.orange.shade400 : Colors.blue.shade400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        // ── Table ────────────────────────────────────────────
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(
                  _isViewAll ? Colors.orange.shade700 : Colors.blue.shade700,
                ),
                headingTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                dividerThickness: 0.5,
                columnSpacing: 24,
                columns: headers.map((cell) {
                  return DataColumn(
                    label: Text(cell?.value?.toString() ?? ''),
                  );
                }).toList(),
                rows: dataRows.asMap().entries.map((entry) {
                  final index = entry.key;
                  final row = entry.value;
                  return DataRow(
                    color: WidgetStateProperty.all(
                      index.isEven ? Colors.white : Colors.grey.shade50,
                    ),
                    cells: List.generate(headers.length, (colIndex) {
                      final cell = colIndex < row.length ? row[colIndex] : null;
                      return DataCell(
                        Text(
                          cell?.value?.toString() ?? '-',
                          style: const TextStyle(fontSize: 13),
                        ),
                      );
                    }),
                  );
                }).toList(),
              ),
            ),
          ),
        ),

        // ── Footer ───────────────────────────────────────────
        Container(
          color: Colors.grey.shade200,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'File: $_fileName',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
              Text(
                'Tab: $_tabName',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}