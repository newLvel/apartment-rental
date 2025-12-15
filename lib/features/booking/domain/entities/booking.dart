class Booking {
  final String id;
  final String apartmentId;
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final double totalPrice;

  const Booking({
    required this.id,
    required this.apartmentId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.totalPrice,
  });
}
