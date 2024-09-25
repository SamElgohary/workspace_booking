import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/workspace.dart';
import '../models/booking.dart';
import '../providers/booking_provider.dart';
import '../providers/workspace_provider.dart';
import '../services/firebase_service.dart';
import 'package:go_router/go_router.dart';

class BookingView extends ConsumerStatefulWidget {
  final Workspace workspace;

  BookingView({required this.workspace});

  @override
  _BookingViewState createState() => _BookingViewState();
}

class _BookingViewState extends ConsumerState<BookingView> {
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  final _timeSlots = ['9 AM - 12 PM', '1 PM - 4 PM'];

  @override
  Widget build(BuildContext context) {
    final booking = ref.watch(bookingProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Book ${widget.workspace.name}')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date Picker
            ListTile(
              title: Text(
                  'Date: ${_selectedDate != null ? _selectedDate!.toLocal().toString().split(' ')[0] : 'Select a date'}'),
              trailing: Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            // Time Slot Picker
            DropdownButtonFormField<String>(
              hint: Text('Select Time Slot'),
              value: _selectedTimeSlot,
              items: _timeSlots
                  .map((slot) => DropdownMenuItem(
                value: slot,
                child: Text(slot),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTimeSlot = value;
                });
              },
            ),
            Spacer(),
            ElevatedButton(
              child: Text('Confirm Booking'),
              onPressed: _selectedDate != null && _selectedTimeSlot != null
                  ? _confirmBooking
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    DateTime initialDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime(initialDate.year + 1),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _confirmBooking() async {
    // Implement booking logic, including checking for availability

    final newBooking = Booking(
      id: '',
      workspaceId: widget.workspace.id,
      date: _selectedDate!,
      timeSlot: _selectedTimeSlot!,
    );

    final firebaseService = ref.read(firebaseServiceProvider);
    await firebaseService.createBooking(newBooking);

    // Navigate to confirmation view
    context.go(
      '/confirmation',
      extra: {
        'workspace': widget.workspace,
        'booking': newBooking,
      },
    );
  }
}
