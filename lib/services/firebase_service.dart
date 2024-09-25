import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/workspace.dart';
import '../models/booking.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Workspace>> getWorkspaces() async {
    var snapshots = await _db.collection('workspaces').get();
    return snapshots.docs
        .map((doc) => Workspace.fromMap(doc.data(), doc.id))
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
        timeSlot: data['timeSlot'],
      );
    }).toList();
  }
}
