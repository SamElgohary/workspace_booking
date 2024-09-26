import 'package:intl/intl.dart';

class Booking {
  final String id;
  final String workspaceId;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime date;

  Booking({
    required this.id,
    required this.workspaceId,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'workspaceId': workspaceId,
      'date': DateFormat('yyyy-MM-dd').format(date), // Format date as "yyyy-MM-dd"
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}
