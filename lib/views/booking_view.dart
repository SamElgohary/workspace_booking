import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../models/booking.dart';
import '../models/workspace.dart';
import '../providers/booking_provider.dart';
import '../providers/workspace_provider.dart';
import '../view_models/booking_view_model.dart';

class BookingView extends ConsumerWidget {
  final Workspace workspace;

  BookingView({required this.workspace});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingViewModel = ref.watch(bookingTimeSlotProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Book ${workspace.name}')),
      body: Column(
        children: [
          ListTile(
            title: Text('Date: ${bookingViewModel.selectedDate != null ? DateFormat('yyyy-MM-dd').format(bookingViewModel.selectedDate!) : 'Select a date'}'),
            trailing: Icon(Icons.calendar_today),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: bookingViewModel.selectedDate ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              );
              if (picked != null) {
                bookingViewModel.generateTimeSlotsForDay(picked);
              }
            },
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: bookingViewModel.slots.length,
              itemBuilder: (context, index) {
                final slot = bookingViewModel.slots[index];
                return InkWell(
                  onTap: () => bookingViewModel.selectTimeSlot(slot),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: slot.isSelected ? Colors.blue : Colors.grey[300],
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Text(DateFormat('hh:mm a').format(slot.time)),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: bookingViewModel.selectedStart != null && bookingViewModel.selectedEnd != null
                ? () => _confirmBooking(context, ref, workspace, bookingViewModel)
                : null,
            child: Text('Confirm Booking'),
          )
        ],
      ),
    );
  }

  void _confirmBooking(BuildContext context, WidgetRef ref, Workspace workspace, BookingTimeViewModel viewModel) async {
    final firebaseService = ref.read(firebaseServiceProvider);
    final newBooking = Booking(
      id: '',
      workspaceId: workspace.id,
      date: viewModel.selectedDate!,
      startTime: DateFormat('hh:mm a').format(viewModel.selectedStart!.time),
      endTime: DateFormat('hh:mm a').format(viewModel.selectedEnd!.time),
    );

    await firebaseService.createBooking(newBooking);
    context.go('/confirmation', extra: {'workspace': workspace, 'booking': newBooking});
  }
}
