import '../entities/booking.dart';

abstract class BookingRepository {
  Future<void> createBooking(Booking booking);
  Future<List<Booking>> getUserBookings(String userId);
}
