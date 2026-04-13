import 'package:flutter/services.dart';
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
    final totalHours = _entries.where((e) => e.isLoggedOut).fold(0.0, (s, e) => s + e.actualHours);
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
                          return _buildEntryCard(entry, index);
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

  // Build expandable entry card with image links
  Widget _buildEntryCard(TimesheetEntry entry, int index) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
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
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Login Order Image ──────────────────────────────
                if (entry.loginImageUrl != null && entry.loginImageUrl!.isNotEmpty) ...[
                  const Text(
                    '📸 Login Order Image',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  _buildImageLinkSection(entry.loginImageUrl!),
                  const SizedBox(height: 16),
                ] else ...[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 8),
                        Text(
                          'No login image available',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // ── Delivery Order Image ──────────────────────────
                if (entry.logoutImageUrl != null && entry.logoutImageUrl!.isNotEmpty) ...[
                  const Text(
                    '📦 Delivery Order Image',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  _buildImageLinkSection(entry.logoutImageUrl!),
                ] else ...[
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 8),
                        Text(
                          'No delivery image available',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build image link section with copyable URL
  Widget _buildImageLinkSection(String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image preview
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),

          // URL link with copy button
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _launchUrl(imageUrl),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.link, size: 14, color: Colors.blue.shade700),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            imageUrl,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontSize: 11,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Copy button
              Tooltip(
                message: 'Copy link',
                child: GestureDetector(
                  onTap: () => _copyToClipboard(imageUrl),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.content_copy, size: 16, color: Colors.green.shade700),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Copy URL to clipboard
  void _copyToClipboard(String url) {
    Clipboard.setData(ClipboardData(text: url));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text('Link copied to clipboard!'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Launch URL in browser
  Future<void> _launchUrl(String url) async {
    try {
      // For web, open in new tab
      if (url.startsWith('http')) {
        // This would normally use url_launcher, but for now just copy
        _copyToClipboard(url);
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}