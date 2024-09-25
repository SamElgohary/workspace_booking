import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/TimeSlot.dart';

class BookingTimeViewModel extends ChangeNotifier {
  List<TimeSlot> slots = [];
  DateTime? selectedDate;
  TimeSlot? selectedStart;
  TimeSlot? selectedEnd;

  void generateTimeSlotsForDay(DateTime date) {
    selectedDate = date;
    slots.clear();
    DateTime startTime = DateTime(date.year, date.month, date.day, 0, 0);
    for (int i = 0; i < 48; i++) { // 30 minute intervals
      slots.add(TimeSlot(time: startTime.add(Duration(minutes: 30 * i))));
    }
    notifyListeners();
  }

  void selectTimeSlot(TimeSlot slot) {
    if (selectedStart == null || selectedEnd != null) {
      slots.forEach((s) => s.isSelected = false); // Reset selections
      selectedStart = slot;
      selectedEnd = null;
      slot.isSelected = true;
    } else {
      if (slot.time.isBefore(selectedStart!.time)) {
        selectedStart = slot;
      }
      selectedEnd = slot;
      applySelection();
    }
    notifyListeners();
  }

  void applySelection() {
    bool inRange = false;
    for (var s in slots) {
      if (s.time == selectedStart!.time) inRange = true;
      s.isSelected = inRange;
      if (s.time == selectedEnd!.time) {
        inRange = false;
      }
    }
  }
}

