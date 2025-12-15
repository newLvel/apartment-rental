import 'package:hive_flutter/hive_flutter.dart';
import '../models/booking_model.dart';

abstract class BookingLocalDataSource {
  Future<void> createBooking(BookingModel booking);
  Future<List<BookingModel>> getUserBookings(String userId);
}

class BookingLocalDataSourceImpl implements BookingLocalDataSource {
  final Box<BookingModel> bookingBox;

  BookingLocalDataSourceImpl(this.bookingBox);

  @override
  Future<void> createBooking(BookingModel booking) async {
    await bookingBox.put(booking.id, booking);
  }

  @override
  Future<List<BookingModel>> getUserBookings(String userId) async {
    return bookingBox.values.where((b) => b.userId == userId).toList();
  }
}
