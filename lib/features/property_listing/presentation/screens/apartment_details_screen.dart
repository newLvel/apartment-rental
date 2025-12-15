import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:apartment_rental/features/property_listing/presentation/providers/property_providers.dart';
import 'package:apartment_rental/features/booking/presentation/screens/booking_dialog.dart';

class ApartmentDetailsScreen extends ConsumerWidget {
  final String apartmentId;
  final bool isOwnerView; // Add this

  const ApartmentDetailsScreen({
    super.key, 
    required this.apartmentId,
    this.isOwnerView = false, // Default false
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allApartmentsAsync = ref.watch(allApartmentsProvider);

    return Scaffold(
      body: allApartmentsAsync.when(
        data: (apartments) {
          final apartment = apartments.firstWhere(
            (apt) => apt.id == apartmentId,
            orElse: () => throw Exception('Apartment not found'),
          );

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    apartment.images.first, 
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(child: Icon(Icons.broken_image, size: 50)),
                      );
                    },
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => context.pop(),
                ),
                actions: [
                  if (!isOwnerView) // Only show favorite if not owner view
                    IconButton(
                      icon: Icon(
                        apartment.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: apartment.isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: () {
                        ref.read(propertyControllerProvider.notifier).toggleFavorite(apartment.id);
                      },
                    ),
                ],
              ),
              // ... (Middle content remains the same, I will use Replace carefully)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        apartment.title,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 18, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              apartment.address,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '\$${apartment.pricePerMonth.toStringAsFixed(0)} / month',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Divider(height: 32),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        apartment.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Divider(height: 32),
                      Text(
                        'Details',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      _buildDetailRow(context, Icons.king_bed, '${apartment.bedrooms} Bedrooms'),
                      _buildDetailRow(context, Icons.bathtub, '${apartment.bathrooms} Bathrooms'),
                      _buildDetailRow(context, Icons.square_foot, '${apartment.areaSquareFeet} sqft'),
                      const Divider(height: 32),
                      Text(
                        'Amenities',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: apartment.amenities
                            .map((amenity) => Chip(
                                  label: Text(amenity),
                                  backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                                ))
                            .toList(),
                      ),
                      const Divider(height: 32),
                      Text(
                        'Owner Information',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue.shade100,
                          child: const Icon(Icons.person, color: Colors.blue),
                        ),
                        title: Text(apartment.owner.name, style: Theme.of(context).textTheme.titleMedium),
                        subtitle: Text(apartment.owner.phoneNumber),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.phone, color: Colors.green),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.message, color: Colors.blue),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (!isOwnerView) // Only show Book Now if not owner view
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => BookingDialog(apartment: apartment),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Book Now', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 20),
          const SizedBox(width: 12),
          Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
