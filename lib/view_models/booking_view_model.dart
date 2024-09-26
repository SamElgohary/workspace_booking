import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  List<Booking> bookedSlots = [];

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
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    debugPrint ('formattedDate $formattedDate');

    final newBooking = Booking(
      id: '',
      workspaceId: workspace.id,
      date: DateTime.parse(formattedDate),  // Store the date as DateTime
      startTime: selectedStart!.time,
      endTime: selectedEnd!.time,
    );

    await firebaseService.createBooking(newBooking);

    return newBooking; // Return the newly created booking
  }

  void generateTimeSlotsForDay(DateTime date, List<Booking> bookingsForDay) {
    selectedDate = date;
    slots.clear();
    bookedSlots = bookingsForDay;  // Save the fetched bookings



    // Set start time to 8:00 AM
    DateTime startTime = DateTime(date.year, date.month, date.day, 8, 0);
    int totalSlots = 15 * 2; // 15 hours * 2 = 30 slots

    for (int i = 0; i < totalSlots; i++) {
      DateTime slotTime = startTime.add(Duration(minutes: 30 * i));

      // Check if this slot is booked

      debugPrint('isTimeSlotBooked slotTime $slotTime  bookingsForDay $bookingsForDay');
      bool isBooked = _isTimeSlotBooked(slotTime, bookingsForDay);

      slots.add(TimeSlot(
        time: slotTime,
        isBooked: isBooked, // Set isBooked flag here
      ));
      debugPrint('Slot: ${DateFormat('hh:mm a').format(slotTime)}, isBooked: $isBooked');

    }

    notifyListeners();
  }

  bool _isTimeSlotBooked(DateTime slotTime, List<Booking> bookingsForDay) {
    for (var booking in bookingsForDay) {
      DateTime startTime = booking.startTime;
      DateTime endTime = booking.endTime;

      // Ensure both are on the same date before comparing time
      if (DateUtils.isSameDay(slotTime, startTime)) {
        if ((slotTime.isAtSameMomentAs(startTime) || slotTime.isAfter(startTime)) &&
            slotTime.isBefore(endTime)) {
          print('Slot: ${DateFormat('hh:mm a').format(slotTime)} is booked!');
          return true;
        }
      }
    }
    return false;
  }



}
