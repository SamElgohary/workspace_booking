class Booking {
  final String id;
  final String workspaceId;
  final DateTime date;
  final String timeSlot;

  Booking({
    required this.id,
    required this.workspaceId,
    required this.date,
    required this.timeSlot,
  });

  Map<String, dynamic> toMap() {
    return {
      'workspaceId': workspaceId,
      'date': date.toIso8601String(),
      'timeSlot': timeSlot,
    };
  }
}
