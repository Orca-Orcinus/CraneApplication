import 'dart:typed_data';
import 'package:craneapplication/Model/TimeSheetModel.dart';
import 'package:craneapplication/Model/TimeSheetService.dart';
import 'package:craneapplication/components/MyDrawer.dart';
import 'package:craneapplication/features/auth/watermark_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class OperatorTimesheetPage extends StatefulWidget {
  final String operatorName;
  const OperatorTimesheetPage({super.key, required this.operatorName});

  @override
  State<OperatorTimesheetPage> createState() => _OperatorTimesheetPageState();
}

class _OperatorTimesheetPageState extends State<OperatorTimesheetPage>
    with SingleTickerProviderStateMixin {
  final TimesheetService _service = TimesheetService();
  final WatermarkService _watermark = WatermarkService();

  late TabController _tabController;

  // ── State ────────────────────────────────────────────────────
  TimesheetEntry? _activeEntry;    // today's active (logged in) entry
  bool _isLoadingActive = true;
  DateTime get _currentMonth => DateTime(DateTime.now().year, DateTime.now().month);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadActiveEntry();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadActiveEntry() async {
    setState(() => _isLoadingActive = true);
    final entry = await _service.getTodayActiveEntry(widget.operatorName);
    setState(() {
      _activeEntry = entry;
      _isLoadingActive = false;
    });
  }

  // ── LOGIN DIALOG ─────────────────────────────────────────────
  Future<void> _showLoginDialog() async {
    final formKey = GlobalKey<FormState>();
    final carPlateCtrl = TextEditingController();
    final customerCtrl = TextEditingController();
    final locationCtrl = TextEditingController();
    final tonCtrl = TextEditingController();
    WorkdayType selectedType = WorkdayType.fullDay;
    Uint8List? loginImageBytes;
    bool isCapturing = false;
    bool isSaving = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          // ── Workday time display ──────────────────────────────
          String workdayLabel() {
            switch (selectedType) {
              case WorkdayType.halfDayMorning:   return 'Half Day Morning (8:00 - 12:00)';
              case WorkdayType.halfDayAfternoon: return 'Half Day Afternoon (13:00 - 17:00)';
              case WorkdayType.fullDay:          return 'Full Day (8:00 - 17:00)';
            }
          }

          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.login, color: Colors.green.shade700),
                const SizedBox(width: 8),
                const Text('Log In'),
              ],
            ),
            content: SizedBox(
              width: 400,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Login time display
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.green.shade700),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Login Time', style: TextStyle(fontSize: 12)),
                                Text(
                                  DateFormat('dd MMM yyyy  HH:mm').format(DateTime.now()),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ── Workday Type ──────────────────────────
                      DropdownButtonFormField<WorkdayType>(
                        value: selectedType,
                        decoration: InputDecoration(
                          labelText: 'Workday Type',
                          prefixIcon: const Icon(Icons.schedule),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: WorkdayType.fullDay,
                            child: Text('Full Day (8:00 - 17:00)  •  8 hrs'),
                          ),
                          DropdownMenuItem(
                            value: WorkdayType.halfDayMorning,
                            child: Text('Half Day Morning (8:00 - 12:00)  •  4 hrs'),
                          ),
                          DropdownMenuItem(
                            value: WorkdayType.halfDayAfternoon,
                            child: Text('Half Day Afternoon (13:00 - 17:00)  •  4 hrs'),
                          ),
                        ],
                        onChanged: (v) => setDialogState(() => selectedType = v!),
                      ),

                      const SizedBox(height: 8),

                      // Workday label chip
                      Chip(
                        avatar: const Icon(Icons.info_outline, size: 16),
                        label: Text(
                          'Standard: ${selectedType == WorkdayType.fullDay ? '8' : '4'} hrs  •  Overtime after that',
                          style: const TextStyle(fontSize: 12),
                        ),
                        backgroundColor: Colors.blue.shade50,
                      ),

                      const SizedBox(height: 12),

                      // Car plate
                      TextFormField(
                        controller: carPlateCtrl,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          labelText: 'Car Plate',
                          prefixIcon: const Icon(Icons.directions_car),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),

                      // Customer
                      TextFormField(
                        controller: customerCtrl,
                        decoration: InputDecoration(
                          labelText: 'Customer',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),

                      // Location
                      TextFormField(
                        controller: locationCtrl,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          prefixIcon: const Icon(Icons.location_on),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),

                      // Ton
                      TextFormField(
                        controller: tonCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Ton',
                          prefixIcon: const Icon(Icons.scale),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (v) {
                          if (v!.isEmpty) return 'Required';
                          if (double.tryParse(v) == null) return 'Invalid number';
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // ── Login Image ────────────────────────────
                      const Text(
                        'Login Photo',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),

                      if (loginImageBytes != null)
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                loginImageBytes!,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8, right: 8,
                              child: GestureDetector(
                                onTap: () => setDialogState(() => loginImageBytes = null),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                                ),
                              ),
                            ),
                          ],
                        ),

                      if (loginImageBytes == null)
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                icon: const Icon(Icons.camera_alt),
                                label: const Text('Camera'),
                                onPressed: isCapturing ? null : () async {
                                  if (locationCtrl.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Enter location first')),
                                    );
                                    return;
                                  }
                                  setDialogState(() => isCapturing = true);
                                  final bytes = await _watermark.pickImageWithWatermark(
                                    source: ImageSource.camera,
                                    location: locationCtrl.text.trim(),
                                    dateTime: DateTime.now(),
                                    carPlate: carPlateCtrl.text.trim().toUpperCase(),
                                    operatorName: widget.operatorName,
                                  );
                                  setDialogState(() {
                                    loginImageBytes = bytes;
                                    isCapturing = false;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                icon: const Icon(Icons.photo_library),
                                label: const Text('Gallery'),
                                onPressed: isCapturing ? null : () async {
                                  if (locationCtrl.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Enter location first')),
                                    );
                                    return;
                                  }
                                  setDialogState(() => isCapturing = true);
                                  final bytes = await _watermark.pickImageWithWatermark(
                                    source: ImageSource.gallery,
                                    location: locationCtrl.text.trim(),
                                    dateTime: DateTime.now(),                                    
                                    carPlate: carPlateCtrl.text.trim().toUpperCase(),
                                    operatorName: widget.operatorName,
                                  );
                                  setDialogState(() {
                                    loginImageBytes = bytes;
                                    isCapturing = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                      if (isCapturing)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                ),
                icon: isSaving
                    ? const SizedBox(width: 16, height: 16,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.login),
                label: Text(isSaving ? 'Logging in...' : 'Log In'),
                onPressed: isSaving ? null : () async {
                  if (!formKey.currentState!.validate()) return;
                  if (loginImageBytes == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please take a login photo'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  setDialogState(() => isSaving = true);
                  try {
                    final now = DateTime.now();
                    final entry = TimesheetEntry(
                      id: '',
                      operatorName: widget.operatorName,
                      carPlate: carPlateCtrl.text.trim().toUpperCase(),
                      customer: customerCtrl.text.trim(),
                      location: locationCtrl.text.trim(),
                      ton: double.parse(tonCtrl.text),
                      date: now,
                      loginTime: now,
                      overtimeHours: 0,
                      workdayType: selectedType,
                    );

                    await _service.saveLoginEntry(entry, loginImageBytes);
                    if (mounted) Navigator.pop(context);
                    await _loadActiveEntry();

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logged in successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  } catch (e) {
                    setDialogState(() => isSaving = false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login failed: $e'), backgroundColor: Colors.red),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  // ── LOGOUT DIALOG ────────────────────────────────────────────
  Future<void> _showLogoutDialog() async {
    if (_activeEntry == null) return;

    final doNumberCtrl = TextEditingController();
    Uint8List? logoutImageBytes;
    bool isCapturing = false;
    bool isSaving = false;

    final now = DateTime.now();
    final overtime = TimesheetEntry.calculateOvertime(
      _activeEntry!.loginTime,
      now,
      _activeEntry!.workdayType,
    );

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.logout, color: Colors.red.shade700),
                const SizedBox(width: 8),
                const Text('Log Out'),
              ],
            ),
            content: SizedBox(
              width: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Summary card ──────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _summaryRow('Login Time', _activeEntry!.loginTimeDisplay),
                          _summaryRow('Logout Time', DateFormat('HH:mm').format(now)),
                          _summaryRow(
                            'Workday Type',
                            _activeEntry!.workdayType == WorkdayType.fullDay
                                ? 'Full Day (8 hrs standard)'
                                : _activeEntry!.workdayType == WorkdayType.halfDayMorning
                                    ? 'Half Day Morning (4 hrs standard)'
                                    : 'Half Day Afternoon (4 hrs standard)',
                          ),
                          const Divider(),
                          _summaryRow(
                            'Total Worked',
                            '${now.difference(_activeEntry!.loginTime).inMinutes ~/ 60}h '
                            '${now.difference(_activeEntry!.loginTime).inMinutes % 60}m',
                          ),
                          _summaryRow(
                            'Overtime',
                            '${overtime.toStringAsFixed(2)} hrs',
                            valueColor: overtime > 0 ? Colors.orange : Colors.green,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Delivery Order ────────────────────────────
                    const Text(
                      'Delivery Order',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    TextFormField(
                      controller: doNumberCtrl,
                      decoration: InputDecoration(
                        labelText: 'DO Number',
                        prefixIcon: const Icon(Icons.receipt_long),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── Logout Image ──────────────────────────────
                    const Text(
                      'Delivery Order Photo',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    if (logoutImageBytes != null)
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.memory(
                              logoutImageBytes!,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8, right: 8,
                            child: GestureDetector(
                              onTap: () => setDialogState(() => logoutImageBytes = null),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close, color: Colors.white, size: 20),
                              ),
                            ),
                          ),
                        ],
                      ),

                    if (logoutImageBytes == null)
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.camera_alt),
                              label: const Text('Camera'),
                              onPressed: isCapturing ? null : () async {
                                setDialogState(() => isCapturing = true);
                                final bytes = await _watermark.pickImageWithWatermark(
                                  source: ImageSource.camera,
                                  location: _activeEntry!.location,
                                  dateTime: DateTime.now(),          
                                  carPlate: _activeEntry!.carPlate,       
                                  operatorName: _activeEntry!.operatorName,        
                                );
                                setDialogState(() {
                                  logoutImageBytes = bytes;
                                  isCapturing = false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.photo_library),
                              label: const Text('Gallery'),
                              onPressed: isCapturing ? null : () async {
                                setDialogState(() => isCapturing = true);
                                final bytes = await _watermark.pickImageWithWatermark(
                                  source: ImageSource.gallery,
                                  location: _activeEntry!.location,
                                  dateTime: DateTime.now(),
                                  carPlate: _activeEntry!.carPlate,
                                  operatorName: _activeEntry!.operatorName,
                                );
                                setDialogState(() {
                                  logoutImageBytes = bytes;
                                  isCapturing = false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                    if (isCapturing)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  foregroundColor: Colors.white,
                ),
                icon: isSaving
                    ? const SizedBox(width: 16, height: 16,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.logout),
                label: Text(isSaving ? 'Logging out...' : 'Log Out'),
                onPressed: isSaving ? null : () async {
                  if (logoutImageBytes == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please take a delivery order photo'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  setDialogState(() => isSaving = true);
                  try {
                    await _service.saveLogout(
                      entryId: _activeEntry!.id,
                      operatorName: widget.operatorName,
                      date: _activeEntry!.date,
                      logoutTime: now,
                      loginTime: _activeEntry!.loginTime,
                      workdayType: _activeEntry!.workdayType,
                      deliveryOrderNumber: doNumberCtrl.text.trim(),
                      imageBytes: logoutImageBytes,
                    );

                    if (mounted) Navigator.pop(context);
                    await _loadActiveEntry();

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logged out successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  } catch (e) {
                    setDialogState(() => isSaving = false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logout failed: $e'), backgroundColor: Colors.red),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  // ── DELETE CONFIRMATION DIALOG ───────────────────────────────
  Future<void> _showDeleteConfirmDialog() async {
    if (_activeEntry == null) return;

    bool isDeleting = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.warning, color: Colors.orange.shade700),
                const SizedBox(width: 8),
                const Text('Delete Entry?'),
              ],
            ),
            content: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Are you sure you want to delete today\'s login entry?',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '⚠️ This action cannot be undone!',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        if (_activeEntry!.isLoggedOut) _bulletPoint('Delete logout photo'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isDeleting ? null : () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade700,
                  foregroundColor: Colors.white,
                ),
                icon: isDeleting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Icon(Icons.delete),
                label: Text(isDeleting ? 'Deleting...' : 'Delete Entry'),
                onPressed: isDeleting
                    ? null
                    : () async {
                        setDialogState(() => isDeleting = true);
                        try {
                          await _service.deleteTimesheetEntry(
                            operatorName: widget.operatorName,
                            date: _activeEntry!.date,
                            entryId: _activeEntry!.id,
                            loginImageUrl: _activeEntry!.loginImageUrl,
                            logoutImageUrl: _activeEntry!.logoutImageUrl,
                          );

                          if (mounted) Navigator.pop(context);
                          await _loadActiveEntry();

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Entry deleted successfully'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          }
                        } catch (e) {
                          setDialogState(() => isDeleting = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Delete failed: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('My Timesheet', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(widget.operatorName, style: const TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(icon: Icon(Icons.today), text: 'Today'),
            Tab(icon: Icon(Icons.list), text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTodayTab(),
          _buildHistoryTab(),
        ],
      ),
    );
  }

  // ── Today Tab ────────────────────────────────────────────────
  Widget _buildTodayTab() {
    if (_isLoadingActive) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Date header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  onPressed: _loadActiveEntry,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Status Card ───────────────────────────────────────
          if (_activeEntry == null) ...[
            // Not logged in
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(Icons.radio_button_unchecked, size: 64, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text(
                      'Not Logged In',
                      style: TextStyle(fontSize: 18, color: Colors.grey.shade600, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap Log In to start your shift',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.login),
                      label: const Text('Log In', style: TextStyle(fontSize: 16)),
                      onPressed: _showLoginDialog,
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            // Logged in — show active entry
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status badge
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.circle, size: 10, color: Colors.green.shade700),
                              const SizedBox(width: 6),
                              Text(
                                'On Shift',
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          DateFormat('HH:mm').format(_activeEntry!.loginTime),
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const Divider(height: 20),

                    // Job details
                    _infoRow(Icons.directions_car, 'Car Plate', _activeEntry!.carPlate),
                    _infoRow(Icons.person, 'Customer', _activeEntry!.customer),
                    _infoRow(Icons.location_on, 'Location', _activeEntry!.location),
                    _infoRow(Icons.scale, 'Ton', '${_activeEntry!.ton}'),
                    _infoRow(
                      Icons.schedule,
                      'Workday',
                      _activeEntry!.workdayType == WorkdayType.fullDay
                          ? 'Full Day (8 hrs)'
                          : _activeEntry!.workdayType == WorkdayType.halfDayMorning
                              ? 'Half Day Morning (4 hrs)'
                              : 'Half Day Afternoon (4 hrs)',
                    ),

                    const SizedBox(height: 8),

                    // Login image preview
                    if (_activeEntry!.loginImageUrl != null) ...[
                      const Text('Login Photo:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          _activeEntry!.loginImageUrl!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Action buttons: Log Out and Delete
                    Row(
                      children: [
                        // Log out button
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade700,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            icon: const Icon(Icons.logout),
                            label: const Text('Log Out', style: TextStyle(fontSize: 16)),
                            onPressed: _showLogoutDialog,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Delete button
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.shade700,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            icon: const Icon(Icons.delete_outline),
                            label: const Text('Delete', style: TextStyle(fontSize: 16)),
                            onPressed: _showDeleteConfirmDialog,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
        ],
      ),
    );
  }

  // ── History Tab ──────────────────────────────────────────────
  Widget _buildHistoryTab() {
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

        final totalHours = entries.where((e) => e.isLoggedOut).fold(0.0, (s, e) => s + e.actualHours);
        final totalOvertime = entries.fold(0.0, (s, e) => s + e.overtimeHours);

        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Summary
            Container(
              color: Colors.blue.shade700,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _summaryChip('Entries', '${entries.length}'),
                  _summaryChip('Total Hrs', totalHours.toStringAsFixed(1)),
                  _summaryChip('Overtime', totalOvertime.toStringAsFixed(1)),
                ],
              ),
            ),

            // List
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
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundColor: entry.isLoggedOut
                            ? Colors.blue.shade50
                            : Colors.orange.shade50,
                        child: Icon(
                          entry.isLoggedOut ? Icons.check : Icons.hourglass_empty,
                          color: entry.isLoggedOut ? Colors.blue : Colors.orange,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        DateFormat('dd MMM yyyy').format(entry.date),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        entry.isLoggedOut
                            ? '${entry.workingHoursDisplay}  •  ${entry.ton} Ton'
                            : 'Logged in at ${entry.loginTimeDisplay}  •  Pending logout',
                        style: TextStyle(
                          color: entry.isLoggedOut ? Colors.black54 : Colors.orange,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _infoRow(Icons.directions_car, 'Car Plate', entry.carPlate),
                              _infoRow(Icons.person, 'Customer', entry.customer),
                              _infoRow(Icons.location_on, 'Location', entry.location),
                              _infoRow(Icons.scale, 'Ton', '${entry.ton}'),
                              _infoRow(Icons.schedule, 'Workday',
                                entry.workdayType == WorkdayType.fullDay
                                    ? 'Full Day'
                                    : entry.workdayType == WorkdayType.halfDayMorning
                                        ? 'Half Day Morning'
                                        : 'Half Day Afternoon',
                              ),
                              if (entry.isLoggedOut) ...[
                                _infoRow(Icons.timer, 'Worked', '${entry.actualHours.toStringAsFixed(2)} hrs'),
                                _infoRow(Icons.more_time, 'Overtime', '${entry.overtimeHours.toStringAsFixed(2)} hrs'),
                                if (entry.deliveryOrderNumber != null && entry.deliveryOrderNumber!.isNotEmpty)
                                  _infoRow(Icons.receipt_long, 'DO Number', entry.deliveryOrderNumber!),
                              ],

                              // ElevatedButton.icon(
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: Colors.orange.shade700, 
                              //     foregroundColor: Colors.white,
                              //     padding: const EdgeInsets.symmetric(vertical: 14),
                              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              //   ),
                              //   onPressed: _showDeleteConfirmDialog,
                              //   label: const Text('Delete',style: TextStyle(fontSize: 16)),
                              // ),

                              // Images
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  if (entry.loginImageUrl != null)
                                    Expanded(
                                      child: Column(
                                        children: [
                                          const Text('Login Photo', style: TextStyle(fontSize: 11)),
                                          const SizedBox(height: 4),
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.network(
                                              entry.loginImageUrl!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (entry.loginImageUrl != null && entry.logoutImageUrl != null)
                                    const SizedBox(width: 8),
                                  if (entry.logoutImageUrl != null)
                                    Expanded(
                                      child: Column(
                                        children: [
                                          const Text('DO Photo', style: TextStyle(fontSize: 11)),
                                          const SizedBox(height: 4),
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.network(
                                              entry.logoutImageUrl!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _summaryChip(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }
}