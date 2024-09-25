class Booking {
  final String id;
  final String workspaceId;
  final String startTime;
  final String endTime;
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
      'date': date.toIso8601String(),
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}
