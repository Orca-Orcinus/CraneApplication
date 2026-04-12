class TimesheetEntry {
  final String id;
  final String operatorName;
  final String carPlate;
  final String customer;
  final String location;
  final double ton;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final double overtimeHours;

  TimesheetEntry({
    required this.id,
    required this.operatorName,
    required this.carPlate,
    required this.customer,
    required this.location,
    required this.ton,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.overtimeHours,
  });

  // ✅ Working hours calculated automatically
  double get workingHours {
    return endTime.difference(startTime).inMinutes / 60.0;
  }

  String get workingHoursDisplay {
    final start = '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
    final end = '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
    return '$start - $end';
  }

  Map<String, dynamic> toFirestore() {
    return {
      'operatorName': operatorName,
      'carPlate': carPlate,
      'customer': customer,
      'location': location,
      'ton': ton,
      'date': date.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'overtimeHours': overtimeHours,
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
      startTime: DateTime.parse(data['startTime']),
      endTime: DateTime.parse(data['endTime']),
      overtimeHours: (data['overtimeHours'] ?? 0).toDouble(),
    );
  }
}