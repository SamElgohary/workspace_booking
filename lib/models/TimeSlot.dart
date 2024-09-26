class TimeSlot {
  DateTime time;
  bool isSelected;
  bool isBooked;

  TimeSlot({required this.time, this.isSelected = false, this.isBooked = false});
}
