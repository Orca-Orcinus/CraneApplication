enum WorkdayType { halfDayMorning, halfDayAfternoon, fullDay }

class TimesheetEntry {
  final String id;
  final String operatorName;
  final String carPlate;
  final String customer;
  final String location;
  final double ton;
  final DateTime date;
  final DateTime loginTime;
  final DateTime? logoutTime;
  final String? loginImageUrl;
  final String? logoutImageUrl;
  final String? deliveryOrderNumber;
  final double overtimeHours;
  final WorkdayType workdayType;

  TimesheetEntry({
    required this.id,
    required this.operatorName,
    required this.carPlate,
    required this.customer,
    required this.location,
    required this.ton,
    required this.date,
    required this.loginTime,
    this.logoutTime,
    this.loginImageUrl,
    this.logoutImageUrl,
    this.deliveryOrderNumber,
    required this.overtimeHours,
    required this.workdayType,
  });

  // ✅ Standard hours based on workday type
  double get standardHours {
    switch (workdayType) {
      case WorkdayType.halfDayMorning:
      case WorkdayType.halfDayAfternoon:
        return 4.0;
      case WorkdayType.fullDay:
        return 8.0;
    }
  }

  // ✅ Actual hours worked
  double get actualHours {
    if (logoutTime == null) return 0;
    return logoutTime!.difference(loginTime).inMinutes / 60.0;
  }

  // ✅ Overtime = anything beyond standard hours
  static double calculateOvertime(
    DateTime login,
    DateTime logout,
    WorkdayType type,
  ) {
    final worked = logout.difference(login).inMinutes / 60.0;
    double standard;
    switch (type) {
      case WorkdayType.halfDayMorning:
      case WorkdayType.halfDayAfternoon:
        standard = 4.0;
        break;
      case WorkdayType.fullDay:
        standard = 8.0;
        break;
    }
    final overtime = worked - standard;
    return overtime > 0 ? double.parse(overtime.toStringAsFixed(2)) : 0.0;
  }

  String get loginTimeDisplay =>
      '${loginTime.hour.toString().padLeft(2, '0')}:${loginTime.minute.toString().padLeft(2, '0')}';

  String get logoutTimeDisplay => logoutTime == null
      ? 'Not logged out'
      : '${logoutTime!.hour.toString().padLeft(2, '0')}:${logoutTime!.minute.toString().padLeft(2, '0')}';

  String get workingHoursDisplay => '$loginTimeDisplay - $logoutTimeDisplay';

  bool get isLoggedOut => logoutTime != null;

  Map<String, dynamic> toFirestore() {
    return {
      'operatorName': operatorName,
      'carPlate': carPlate,
      'customer': customer,
      'location': location,
      'ton': ton,
      'date': date.toIso8601String(),
      'loginTime': loginTime.toIso8601String(),
      'logoutTime': logoutTime?.toIso8601String(),
      'loginImageUrl': loginImageUrl,
      'logoutImageUrl': logoutImageUrl,
      'deliveryOrderNumber': deliveryOrderNumber,
      'overtimeHours': overtimeHours,
      'workdayType': workdayType.index,
    };
  }

  factory TimesheetEntry.fromFirestore(Map<String, dynamic> data, String id) {
    return TimesheetEntry(
      id: id,
      operatorName: data['operatorName'] ?? '',
      carPlate: data['carPlate'] ?? '',
      customer: data['customer'] ?? '',
      location: data['location'] ?? '',
      ton: (data['ton'] ?? 0).toDouble(),
      date: DateTime.parse(data['date']),
      loginTime: DateTime.parse(data['loginTime']),
      logoutTime: data['logoutTime'] != null ? DateTime.parse(data['logoutTime']) : null,
      loginImageUrl: data['loginImageUrl'],
      logoutImageUrl: data['logoutImageUrl'],
      deliveryOrderNumber: data['deliveryOrderNumber'],
      overtimeHours: (data['overtimeHours'] ?? 0).toDouble(),
      workdayType: WorkdayType.values[data['workdayType'] ?? 2],
    );
  }

  TimesheetEntry copyWith({
    DateTime? logoutTime,
    String? logoutImageUrl,
    String? deliveryOrderNumber,
    double? overtimeHours,
  }) {
    return TimesheetEntry(
      id: id,
      operatorName: operatorName,
      carPlate: carPlate,
      customer: customer,
      location: location,
      ton: ton,
      date: date,
      loginTime: loginTime,
      logoutTime: logoutTime ?? this.logoutTime,
      loginImageUrl: loginImageUrl,
      logoutImageUrl: logoutImageUrl ?? this.logoutImageUrl,
      deliveryOrderNumber: deliveryOrderNumber ?? this.deliveryOrderNumber,
      overtimeHours: overtimeHours ?? this.overtimeHours,
      workdayType: workdayType,
    );
  }
}