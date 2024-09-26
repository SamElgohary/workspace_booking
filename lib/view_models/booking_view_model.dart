import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/TimeSlot.dart';
import '../models/booking.dart';
import '../models/workspace.dart';
import '../providers/workspace_provider.dart';

class BookingTimeViewModel extends ChangeNotifier {
  List<TimeSlot> slots = [];
  DateTime? selectedDate;
  DateTime? focusedDay;
  TimeSlot? selectedStart;
  TimeSlot? selectedEnd;

  // void generateTimeSlotsForDay(DateTime date) {
  //   selectedDate = date;
  //   slots.clear();
  //   DateTime startTime = DateTime(date.year, date.month, date.day, 0, 0);
  //   for (int i = 0; i < 48; i++) { // 30-minute intervals
  //     slots.add(TimeSlot(time: startTime.add(Duration(minutes: 30 * i))));
  //   }
  //   notifyListeners();
  // }

  void generateTimeSlotsForDay(DateTime date) {
    selectedDate = date;
    slots.clear();

    // Set start time to 8:00 AM
    DateTime startTime = DateTime(date.year, date.month, date.day, 8, 0);

    // We want 30-minute intervals from 8:00 AM to 11:00 PM (15 hours = 30 slots)
    int totalSlots = 15 * 2; // 15 hours * 2 = 30 slots

    for (int i = 0; i < totalSlots; i++) {
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

  Future<Booking> confirmBooking(Workspace workspace, WidgetRef ref) async {
    final firebaseService = ref.read(firebaseServiceProvider);

    final newBooking = Booking(
      id: '',
      workspaceId: workspace.id,
      date: selectedDate!,
      startTime: DateFormat('hh:mm a').format(selectedStart!.time),
      endTime: DateFormat('hh:mm a').format(selectedEnd!.time),
    );

    await firebaseService.createBooking(newBooking);

    return newBooking; // Return the newly created booking
  }}
