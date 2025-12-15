import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants.dart';
import '../../data/datasources/booking_local_datasource.dart';
import '../../data/models/booking_model.dart';
import '../../data/repositories/booking_repository_impl.dart';
import '../../domain/entities/booking.dart';
import '../../domain/repositories/booking_repository.dart';

part 'booking_providers.g.dart';

@riverpod
BookingLocalDataSource bookingLocalDataSource(BookingLocalDataSourceRef ref) {
  final box = Hive.box<BookingModel>(AppConstants.bookingBox);
  return BookingLocalDataSourceImpl(box);
}

@riverpod
BookingRepository bookingRepository(BookingRepositoryRef ref) {
  final dataSource = ref.watch(bookingLocalDataSourceProvider);
  return BookingRepositoryImpl(dataSource);
}

@riverpod
Future<List<Booking>> userBookings(UserBookingsRef ref, String userId) async {
  final repository = ref.watch(bookingRepositoryProvider);
  return repository.getUserBookings(userId);
}

@riverpod
class BookingController extends _$BookingController {
  @override
  FutureOr<void> build() {}

  Future<void> createBooking({
    required String apartmentId,
    required DateTime startDate,
    required DateTime endDate,
    required double totalPrice,
  }) async {
    final repository = ref.read(bookingRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // Assuming 'user1' as the logged-in user for this POC
      const userId = 'user1'; 
      final booking = Booking(
        id: const Uuid().v4(),
        apartmentId: apartmentId,
        userId: userId,
        startDate: startDate,
        endDate: endDate,
        status: 'confirmed',
        totalPrice: totalPrice,
      );
      await repository.createBooking(booking);
      ref.invalidate(userBookingsProvider(userId));
    });
  }
}
