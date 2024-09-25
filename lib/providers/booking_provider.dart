import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/booking.dart';
import '../services/firebase_service.dart';

final bookingProvider = StateProvider<Booking?>((ref) => null);
