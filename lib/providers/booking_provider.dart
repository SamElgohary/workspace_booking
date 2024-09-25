import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/booking.dart';
import '../services/firebase_service.dart';
import '../view_models/booking_view_model.dart';

final bookingProvider = StateProvider<Booking?>((ref) => null);
final bookingTimeSlotProvider = ChangeNotifierProvider((ref) => BookingTimeViewModel());
