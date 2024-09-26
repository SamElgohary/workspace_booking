import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/workspace.dart';
import '../models/booking.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Workspace>> getWorkspaces() async {
    var snapshots = await _db.collection('workspaces').get();
    return snapshots.docs
        .map((doc) => Workspace.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<void> createBooking(Booking booking) async {
    await _db.collection('bookings').add(booking.toMap());
  }

  Future<List<Booking>> getBookings(String workspaceId) async {
    var snapshots = await _db
        .collection('bookings')
        .where('workspaceId', isEqualTo: workspaceId)
        .get();
    return snapshots.docs.map((doc) {
      var data = doc.data();
      return Booking(
        id: doc.id,
        workspaceId: data['workspaceId'],
        date: DateTime.parse(data['date']),
        startTime: data['start_time'],
        endTime: data['end_time'],
      );
    }).toList();
  }

  Future<List<Booking>> getBookingsForDay(String workspaceId, DateTime date) async {
    // Format the date as a string (since it's stored as a string in Firestore)
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    // Query Firestore for bookings based on workspaceId and selected date
    final bookingsQuery = await FirebaseFirestore.instance
        .collection('bookings')
        .where('workspaceId', isEqualTo: workspaceId)
        .where('date', isEqualTo: formattedDate) // Query date as a string
        .get();

    // Convert the fetched documents to Booking objects
    List<Booking> bookings = bookingsQuery.docs.map((doc) {
      var data = doc.data();
      return Booking(
        id: doc.id,
        workspaceId: data['workspaceId'],
        startTime: (data['start_time'] as Timestamp).toDate(), // Handle Timestamp correctly
        endTime: (data['end_time'] as Timestamp).toDate(),     // Handle Timestamp correctly
        date: DateTime.parse(data['date']), // Parse the date string to DateTime
      );
    }).toList();

    print('bookingsForDay response: $bookings');
    return bookings;
  }

}
