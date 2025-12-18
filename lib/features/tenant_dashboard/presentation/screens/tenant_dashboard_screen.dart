import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:apartment_rental/features/booking/presentation/providers/booking_providers.dart';
import 'package:apartment_rental/features/property_listing/presentation/providers/property_providers.dart';
import 'package:apartment_rental/core/widgets/smart_image.dart';

class TenantDashboardScreen extends ConsumerWidget {
  const TenantDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const userId = 'user1'; // Mock user
    final bookingsAsync = ref.watch(userBookingsProvider(userId));
    final apartmentsAsync = ref.watch(allApartmentsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Light grey bg
      appBar: AppBar(
        title: const Text(
          'My properties',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: bookingsAsync.when(
        data: (bookings) {
          if (bookings.isEmpty) {
            return const Center(child: Text('No active rentals.'));
          }
          return apartmentsAsync.when(
            data: (apartments) {
              // Create a list of valid (booking, apartment) pairs
              final validRentals = <MapEntry<dynamic, dynamic>>[];
              for (final booking in bookings) {
                try {
                  final apartment = apartments.firstWhere((apt) => apt.id == booking.apartmentId);
                  validRentals.add(MapEntry(booking, apartment));
                } catch (e) {
                  // Apartment not found for this booking, so we skip it.
                  debugPrint('Apartment with id ${booking.apartmentId} not found for booking ${booking.id}');
                }
              }

              if (validRentals.isEmpty) {
                 return const Center(child: Text('Could not find details for your rentals.'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: validRentals.length,
                itemBuilder: (context, index) {
                  final booking = validRentals[index].key;
                  final apartment = validRentals[index].value;
                  return _buildPropertyCard(context, booking, apartment);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error loading apartments: $err')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildPropertyCard(BuildContext context, dynamic booking, dynamic apartment) {
    return GestureDetector(
      onTap: () {
        context.push('/tenant_property_management/${booking.apartmentId}');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            SmartImage(
              imageUrl: apartment.images.first,
              width: 80,
              height: 80,
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    apartment.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    apartment.address,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ref: ${booking.id.substring(0, 6)}',
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  const SizedBox(height: 12),
                  // Mock Tags
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       _buildStatusTag('Contract end: 12/03/2026', Colors.black),
                       _buildStatusTag('Due in 122 day', Colors.blue),
                    ],
                  )
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTag(String text, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
    );
  }
}
