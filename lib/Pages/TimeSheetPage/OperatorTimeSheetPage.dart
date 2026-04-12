import 'package:craneapplication/components/MyDrawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Model/TimeSheetService.dart';
import '../../Model/TimeSheetModel.dart';

class OperatorTimesheetPage extends StatefulWidget {
  final String operatorName;
  const OperatorTimesheetPage({super.key, required this.operatorName});

  @override
  State<OperatorTimesheetPage> createState() => _OperatorTimesheetPageState();
}

class _OperatorTimesheetPageState extends State<OperatorTimesheetPage> {
  final TimesheetService _service = TimesheetService();
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _carPlateController = TextEditingController();
  final _customerController = TextEditingController();
  final _locationController = TextEditingController();
  final _tonController = TextEditingController();
  final _overtimeController = TextEditingController(text: '0');

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 17, minute: 0);
  bool _isSaving = false;

  DateTime get _currentMonth => DateTime(DateTime.now().year, DateTime.now().month);

  @override
  void dispose() {
    _carPlateController.dispose();
    _customerController.dispose();
    _locationController.dispose();
    _tonController.dispose();
    _overtimeController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  double _calculateWorkingHours() {
    final start = DateTime(
      _selectedDate.year, _selectedDate.month, _selectedDate.day,
      _startTime.hour, _startTime.minute,
    );
    final end = DateTime(
      _selectedDate.year, _selectedDate.month, _selectedDate.day,
      _endTime.hour, _endTime.minute,
    );
    return end.difference(start).inMinutes / 60.0;
  }

  Future<void> _saveEntry() async {
    if (!_formKey.currentState!.validate()) return;

    if (_calculateWorkingHours() <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('End time must be after start time'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final startDateTime = DateTime(
        _selectedDate.year, _selectedDate.month, _selectedDate.day,
        _startTime.hour, _startTime.minute,
      );
      final endDateTime = DateTime(
        _selectedDate.year, _selectedDate.month, _selectedDate.day,
        _endTime.hour, _endTime.minute,
      );

      final entry = TimesheetEntry(
        id: '',
        operatorName: widget.operatorName,
        carPlate: _carPlateController.text.trim().toUpperCase(),
        customer: _customerController.text.trim(),
        location: _locationController.text.trim(),
        ton: double.parse(_tonController.text),
        date: _selectedDate,
        startTime: startDateTime,
        endTime: endDateTime,
        overtimeHours: double.tryParse(_overtimeController.text) ?? 0,
      );

      await _service.saveEntry(entry);

      // Clear form
      _carPlateController.clear();
      _customerController.clear();
      _locationController.clear();
      _tonController.clear();
      _overtimeController.text = '0';
      setState(() => _selectedDate = DateTime.now());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Entry saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: MyDrawer(),
        // backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          // backgroundColor: Colors.blue.shade700,
          // foregroundColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('My Timesheet', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(widget.operatorName, style: const TextStyle(fontSize: 12, color: Colors.white70)),
            ],
          ),
          bottom: const TabBar(
            // indicatorColor: Colors.white,
            // labelColor: Colors.white,
            // unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(icon: Icon(Icons.add), text: 'Add Entry'),
              Tab(icon: Icon(Icons.list), text: 'My Entries'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAddEntryTab(),
            _buildEntriesTab(),
          ],
        ),
      ),
    );
  }

  // ── Add Entry Tab ────────────────────────────────────────────
  Widget _buildAddEntryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _sectionCard(
              title: 'Job Details',
              icon: Icons.work,
              children: [
                // Car Plate
                _buildTextField(
                  controller: _carPlateController,
                  label: 'Car Plate',
                  icon: Icons.directions_car,
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),

                // Customer
                _buildTextField(
                  controller: _customerController,
                  label: 'Customer',
                  icon: Icons.person,
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),

                // Location
                _buildTextField(
                  controller: _locationController,
                  label: 'Location',
                  icon: Icons.location_on,
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),

                // Ton
                _buildTextField(
                  controller: _tonController,
                  label: 'Ton',
                  icon: Icons.scale,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v!.isEmpty) return 'Required';
                    if (double.tryParse(v) == null) return 'Invalid number';
                    return null;
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            _sectionCard(
              title: 'Time Details',
              icon: Icons.access_time,
              children: [
                // Date picker
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_today, color: Colors.blue),
                  title: const Text('Date'),
                  subtitle: Text(DateFormat('dd MMMM yyyy').format(_selectedDate)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _pickDate,
                ),
                const Divider(),

                // Start time
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.play_arrow, color: Colors.green),
                  title: const Text('Start Time'),
                  subtitle: Text(_startTime.format(context)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _pickTime(true),
                ),
                const Divider(),

                // End time
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.stop, color: Colors.red),
                  title: const Text('End Time'),
                  subtitle: Text(_endTime.format(context)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _pickTime(false),
                ),
                const Divider(),

                // Working hours display
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.timer, color: Colors.orange),
                  title: const Text('Total Working Hours'),
                  subtitle: Text(
                    '${_calculateWorkingHours().toStringAsFixed(2)} hrs',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
                const Divider(),

                // Overtime
                _buildTextField(
                  controller: _overtimeController,
                  label: 'Overtime Hours',
                  icon: Icons.more_time,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (double.tryParse(v!) == null) return 'Invalid number';
                    return null;
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Save button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: _isSaving
                  ? const SizedBox(
                      width: 20, height: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Icon(Icons.save),
              label: Text(_isSaving ? 'Saving...' : 'Save Entry'),
              onPressed: _isSaving ? null : _saveEntry,
            ),
          ],
        ),
      ),
    );
  }

  // ── Entries Tab ──────────────────────────────────────────────
  Widget _buildEntriesTab() {
    return StreamBuilder<List<TimesheetEntry>>(
      stream: _service.streamEntriesForMonth(widget.operatorName, _currentMonth),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final entries = snapshot.data ?? [];

        if (entries.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  'No entries for ${DateFormat('MMMM yyyy').format(_currentMonth)}',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          );
        }

        // Summary
        final totalTon = entries.fold(0.0, (s, e) => s + e.ton);
        final totalHours = entries.fold(0.0, (s, e) => s + e.workingHours);
        final totalOvertime = entries.fold(0.0, (s, e) => s + e.overtimeHours);

        return Column(
          children: [
            // Summary banner
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue.shade700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _summaryItem('Entries', '${entries.length}'),
                  _summaryItem('Total Ton', totalTon.toStringAsFixed(1)),
                  _summaryItem('Total Hrs', totalHours.toStringAsFixed(1)),
                  _summaryItem('Overtime', totalOvertime.toStringAsFixed(1)),
                ],
              ),
            ),

            // Entries list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: entries.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('dd MMM yyyy').format(entry.date),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '${entry.ton} Ton',
                                      style: TextStyle(
                                        color: Colors.blue.shade700,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  PopupMenuButton(
                                    icon: Icon(Icons.more_vert, color: Colors.grey.shade600),
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          child: Row(
                                            children: const [
                                              Icon(Icons.delete, color: Colors.red, size: 18),
                                              SizedBox(width: 8),
                                              Text('Delete', style: TextStyle(color: Colors.red)),
                                            ],
                                          ),
                                          onTap: () => _showDeleteConfirmation(entry),
                                        ),
                                      ];
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _entryRow(Icons.directions_car, entry.carPlate),
                          _entryRow(Icons.person, entry.customer),
                          _entryRow(Icons.location_on, entry.location),
                          _entryRow(Icons.access_time, entry.workingHoursDisplay),
                          if (entry.overtimeHours > 0)
                            _entryRow(Icons.more_time, '${entry.overtimeHours} hrs overtime',
                                color: Colors.orange),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteConfirmation(TimesheetEntry entry) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Entry'),
          content: Text(
            'Are you sure you want to delete this entry?\n\n'
            '${DateFormat('dd MMM yyyy').format(entry.date)}\n'
            '${entry.carPlate} - ${entry.customer}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await _service.deleteEntry(
                    widget.operatorName,
                    entry.date,
                    entry.id,
                  );
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Entry deleted successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to delete: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
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

  Widget _entryRow(IconData icon, String text, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color ?? Colors.grey),
          const SizedBox(width: 6),
          Expanded(child: Text(text, style: TextStyle(fontSize: 13, color: color ?? Colors.black87))),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon, color: Colors.blue.shade700, size: 20),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ]),
            const Divider(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }
}