import '../../domain/entities/booking.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_local_datasource.dart';
import '../models/booking_model.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingLocalDataSource localDataSource;

  BookingRepositoryImpl(this.localDataSource);

  @override
  Future<void> createBooking(Booking booking) async {
    final model = BookingModel(
      id: booking.id,
      apartmentId: booking.apartmentId,
      userId: booking.userId,
      startDate: booking.startDate,
      endDate: booking.endDate,
      status: booking.status,
      totalPrice: booking.totalPrice,
    );
    await localDataSource.createBooking(model);
  }

  @override
  Future<List<Booking>> getUserBookings(String userId) async {
    final models = await localDataSource.getUserBookings(userId);
    return models.map((m) => Booking(
      id: m.id,
      apartmentId: m.apartmentId,
      userId: m.userId,
      startDate: m.startDate,
      endDate: m.endDate,
      status: m.status,
      totalPrice: m.totalPrice,
    )).toList();
  }
}
