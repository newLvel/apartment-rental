import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:apartment_rental/features/property_listing/presentation/providers/property_providers.dart';
import 'package:apartment_rental/features/property_listing/presentation/widgets/property_card.dart';
import 'package:apartment_rental/features/authentication/presentation/providers/auth_provider.dart'; // Import AuthProvider

class OwnerHomeScreen extends ConsumerWidget {
  const OwnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final currentOwnerId = authState.value?.id; // Get logged-in user's ID

    if (currentOwnerId == null) {
      return Scaffold( // Removed const
        appBar: AppBar(title: const Text('Owner Dashboard')),
        body: const Center(child: Text('Please log in as an owner.')),
      );
    }

    final ownedApartmentsAsync = ref.watch(apartmentsByOwnerProvider(currentOwnerId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {
               GoRouter.of(context).push('/chats');
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_home_work),
            onPressed: () {
              // Navigate to Add New Property Screen
              GoRouter.of(context).push('/add_property');
            },
          ),
        ],
      ),
      body: ownedApartmentsAsync.when(
        data: (apartments) {
          if (apartments.isEmpty) {
            return const Center(child: Text('You have no properties listed.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: apartments.length,
            itemBuilder: (context, index) {
              final apartment = apartments[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: PropertyCard(
                  apartment: apartment,
                  onTap: () {
                    // Navigate to management screen
                    GoRouter.of(context).push('/owner_property_management/${apartment.id}');
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}