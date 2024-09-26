import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/booking.dart';
import '../models/workspace.dart';
import '../providers/booking_provider.dart';
import '../providers/workspace_provider.dart';
import '../ui/components/bottomButton.dart';
import '../utlis/colors.dart';
import '../utlis/size.dart';
import '../view_models/booking_view_model.dart';

class BookingView extends ConsumerStatefulWidget {
  final Workspace workspace;

  BookingView({required this.workspace});

  @override
  _BookingViewState createState() => _BookingViewState();
}

class _BookingViewState extends ConsumerState<BookingView> {
  @override
  void initState() {
    super.initState();

    // Ensure that time slots for today are generated when the screen first loads.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bookingViewModel = ref.read(bookingTimeSlotProvider);

      if (bookingViewModel.selectedDate == null) {
        bookingViewModel.generateTimeSlotsForDay(DateTime.now());
        bookingViewModel.selectedDate = DateTime.now();  // Set today's date as the selected date
        bookingViewModel.focusedDay = DateTime.now();   // Set today's date as the focused date
      }

      debugPrint('WidgetsBinding executed');
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookingViewModel = ref.watch(bookingTimeSlotProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Select a time')),
      body: Column(
        children: [
          TableCalendar(
            calendarFormat: CalendarFormat.twoWeeks,
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2030, 1, 1),
            focusedDay: bookingViewModel.focusedDay ?? DateTime.now(),
            selectedDayPredicate: (day) {
              return isSameDay(bookingViewModel.selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              debugPrint('selectedDay $selectedDay focusedDay $focusedDay ');
              bookingViewModel.generateTimeSlotsForDay(selectedDay);

              // Update both selectedDay and focusedDay in the view model
              bookingViewModel.selectedDate = selectedDay;
              bookingViewModel.focusedDay = focusedDay;  // Now update focusedDay too
              debugPrint('bookingViewModel.selectedDate ${bookingViewModel.selectedDate}');
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: primaryColorAccent, // Color for today's date
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: primaryColor, // Color for the selected date
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: Colors.white, // Text color for today's date
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white, // Text color for the selected date
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,           // Number of columns
                crossAxisSpacing: 8.0,       // Space between columns
                mainAxisSpacing: 8.0,        // Space between rows
                childAspectRatio: 3,
              ),
              itemCount: bookingViewModel.slots.length,
              itemBuilder: (context, index) {
                final slot = bookingViewModel.slots[index];
                return InkWell(
                  onTap: () => bookingViewModel.selectTimeSlot(slot),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: slot.isSelected ? primaryColor : Colors.grey[300],
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Text(
                      DateFormat('hh:mm a').format(slot.time),
                      style: TextStyle(
                        color: slot.isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomButton(
        text: 'Confirm Booking',
        onTap: () async{
          if (bookingViewModel.selectedStart != null && bookingViewModel.selectedEnd != null) {
            await bookingViewModel.confirmBooking(widget.workspace, ref);
            context.go('/confirmation', extra: {'workspace': widget.workspace, 'booking': bookingViewModel});
          }
        },
      ),
    );
  }

}
