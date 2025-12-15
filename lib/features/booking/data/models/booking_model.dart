import 'package:hive/hive.dart';

part 'booking_model.g.dart';

@HiveType(typeId: 2)
class BookingModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String apartmentId;
  @HiveField(2)
  final String userId;
  @HiveField(3)
  final DateTime startDate;
  @HiveField(4)
  final DateTime endDate;
  @HiveField(5)
  final String status; // 'pending', 'confirmed', 'cancelled'
  @HiveField(6)
  final double totalPrice;

  BookingModel({
    required this.id,
    required this.apartmentId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.totalPrice,
  });
}
