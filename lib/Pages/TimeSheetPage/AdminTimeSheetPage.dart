import 'package:craneapplication/components/MyDrawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Model/TimeSheetService.dart';
import '../../Model/TimeSheetModel.dart';

class AdminTimesheetPage extends StatefulWidget {
  const AdminTimesheetPage({super.key});

  @override
  State<AdminTimesheetPage> createState() => _AdminTimesheetPageState();
}

class _AdminTimesheetPageState extends State<AdminTimesheetPage> {
  final TimesheetService _service = TimesheetService();

  List<String> _operators = [];
  String? _selectedOperator;
  DateTime _selectedMonth = DateTime.now();
  List<TimesheetEntry> _entries = [];
  bool _isLoading = false;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    _loadOperators();
  }

  Future<void> _loadOperators() async {
    final operators = await _service.getAllOperators();
    setState(() => _operators = operators);
  }

  Future<void> _loadEntries() async {
    if (_selectedOperator == null) return;
    setState(() => _isLoading = true);
    final entries = await _service.getEntriesForMonth(_selectedOperator!, _selectedMonth);
    setState(() {
      _entries = entries;
      _isLoading = false;
    });
  }

  Future<void> _pickMonth() async {
    final now = DateTime.now();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Month'),
          content: SizedBox(
            width: 300,
            height: 300,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                final month = DateTime(now.year, index + 1);
                final isSelected = month.month == _selectedMonth.month &&
                    month.year == _selectedMonth.year;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedMonth = month);
                    Navigator.pop(context);
                    _loadEntries();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue.shade700 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      DateFormat('MMM').format(month),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _downloadExcel() async {
    if (_selectedOperator == null) return;
    setState(() => _isDownloading = true);
    try {
      await _service.generateAndDownloadExcel(_selectedOperator!, _selectedMonth);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Downloaded: ${_service.getExcelFileName(_selectedOperator!, _selectedMonth)}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download failed: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      setState(() => _isDownloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalTon = _entries.fold(0.0, (s, e) => s + e.ton);
    final totalHours = _entries.fold(0.0, (s, e) => s + e.workingHours);
    final totalOvertime = _entries.fold(0.0, (s, e) => s + e.overtimeHours);

    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      drawer: MyDrawer(),
      appBar: AppBar(
        // backgroundColor: Colors.blue.shade700,
        // foregroundColor: Colors.white,
        title: const Text('Admin — Timesheets', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadOperators),
        ],
      ),
      body: Column(
        children: [
          // ── Filter Panel ───────────────────────────────────────
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Operator dropdown
                DropdownButtonFormField<String>(
                  initialValue: _selectedOperator,
                  decoration: InputDecoration(
                    labelText: 'Select Operator',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  items: _operators.map((op) {
                    return DropdownMenuItem<String>(value: op, child: Text(op));
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedOperator = value);
                    _loadEntries();
                  },
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    // Month picker
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.calendar_month),
                        label: Text(DateFormat('MMMM yyyy').format(_selectedMonth)),
                        onPressed: _pickMonth,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Download button
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: _isDownloading
                          ? const SizedBox(
                              width: 18, height: 18,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Icon(Icons.download),
                      label: Text(_isDownloading ? 'Downloading...' : 'Download Excel'),
                      onPressed: (_selectedOperator == null || _isDownloading) ? null : _downloadExcel,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Summary ────────────────────────────────────────────
          if (_entries.isNotEmpty)
            Container(
              color: Colors.blue.shade700,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _summaryItem('Entries', '${_entries.length}'),
                  _summaryItem('Total Ton', totalTon.toStringAsFixed(1)),
                  _summaryItem('Total Hrs', totalHours.toStringAsFixed(1)),
                  _summaryItem('Overtime', totalOvertime.toStringAsFixed(1)),
                ],
              ),
            ),

          // ── Entries ────────────────────────────────────────────
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _entries.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inbox, size: 64, color: Colors.grey.shade400),
                            const SizedBox(height: 16),
                            Text(
                              _selectedOperator == null
                                  ? 'Select an operator to view entries'
                                  : 'No entries for ${_selectedOperator!} in ${DateFormat('MMMM yyyy').format(_selectedMonth)}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(12),
                        itemCount: _entries.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final entry = _entries[index];
                          return Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue.shade50,
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                DateFormat('dd MMM yyyy').format(entry.date),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${entry.carPlate}  •  ${entry.customer}  •  ${entry.location}\n'
                                '${entry.workingHoursDisplay}  •  ${entry.ton} Ton'
                                '${entry.overtimeHours > 0 ? '  •  ${entry.overtimeHours}h OT' : ''}',
                              ),
                              isThreeLine: true,
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }
}