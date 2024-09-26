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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _fetchAndGenerateTimeSlotsForDay(DateTime.now());

      debugPrint('WidgetsBinding executed');
    });
  }

  Future<void> _fetchAndGenerateTimeSlotsForDay(DateTime date) async {
    final firebaseService = ref.read(firebaseServiceProvider);

    // Fetch bookings from your database for the selected date
    List<Booking> bookingsForDay = await firebaseService.getBookingsForDay(widget.workspace.spaceId,date);


    // Generate time slots with booked slots for the selected date
    ref.read(bookingTimeSlotProvider).generateTimeSlotsForDay(date, bookingsForDay);
  }

  @override
  Widget build(BuildContext context) {
    final bookingViewModel = ref.watch(bookingTimeSlotProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Select a time')),
      body: Column(
        children: [
          TableCalendar(
            calendarFormat: CalendarFormat.month,
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2030, 1, 1),
            focusedDay: bookingViewModel.focusedDay ?? DateTime.now(),
            selectedDayPredicate: (day) {
              return isSameDay(bookingViewModel.selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) async {
              await _fetchAndGenerateTimeSlotsForDay(selectedDay);

              debugPrint('selectedDay $selectedDay focusedDay $focusedDay ');
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  const Text('Avalible Time'),
                  const SizedBox(width: 2,),
                  Icon(Icons.circle,color: Colors.grey[300],size: 12,),
                ],),
                const Row(children: [
                  Text('Booked Time'),
                  SizedBox(width: 2,),
                  Icon(Icons.circle,color: Colors.red,size: 12,),
                ],),
                const Row(children: [
                  Text('Selected Time'),
                  SizedBox(width: 2,),
                  Icon(Icons.circle,color:primaryColor,size: 12,),
                ],),
              ],
            )),


          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
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

                  // Set color to red if the slot is booked, otherwise normal logic
                  Color? slotColor = slot.isBooked
                      ? Colors.red
                      : (slot.isSelected ? primaryColor : Colors.grey[300]);

                  return InkWell(
                    onTap: slot.isBooked ? null : () => bookingViewModel.selectTimeSlot(slot), // Disable tap if booked
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: slotColor,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8.0),

                      ),
                      child: Text(
                        DateFormat('hh:mm a').format(slot.time),
                        style: TextStyle(
                          color: slot.isBooked ? Colors.white : (slot.isSelected ? Colors.white : Colors.black87),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),


        ],
      ),
      bottomNavigationBar: BottomButton(
        text: 'Confirm Booking',
        onTap: () async {
          if (bookingViewModel.selectedStart != null && bookingViewModel.selectedEnd != null) {
            // Confirm the booking and get the newly created booking object
            final newBooking = await bookingViewModel.confirmBooking(widget.workspace, ref);

            // Navigate to confirmation page with Workspace and Booking
            context.go(
              '/confirmation',
              extra: {'workspace': widget.workspace, 'booking': newBooking}, // Pass actual Booking object here
            );
          }
        },
      ),
    );
  }
}
