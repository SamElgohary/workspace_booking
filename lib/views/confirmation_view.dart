import 'package:flutter/material.dart';
import '../models/workspace.dart';
import '../models/booking.dart';
import 'package:intl/intl.dart';

class ConfirmationView extends StatelessWidget {
  final Workspace workspace;
  final Booking booking;

  ConfirmationView({required this.workspace, required this.booking});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(booking.date);

    return Scaffold(
      appBar: AppBar(title: Text('Booking Confirmed')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Your booking is confirmed!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Workspace: ${workspace.name}'),
            Text('Location: ${workspace.location}'),
            Text('Amenities: ${workspace.amenities.join(', ')}'),
            SizedBox(height: 10),
            Text('Date: $formattedDate'),
            Text('Time Slot: ${booking.startTime} to ${booking.endTime}'),
            Spacer(),
            ElevatedButton(
              child: Text('Back to Home'),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
