import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/property_providers.dart';
import '../widgets/property_card.dart';

class ClientHomeScreen extends ConsumerWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredAsync = ref.watch(featuredApartmentsProvider);
    final allAsync = ref.watch(allApartmentsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Location', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
                      const SizedBox(height: 4),
                      const Row(
                        children: [
                          Text('New York, USA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          Icon(Icons.keyboard_arrow_down, color: Colors.blue),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 40, 
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.chat_bubble_outline),
                      onPressed: () => context.push('/chats'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Search Bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search address, city...',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => context.push('/filters'),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue, // Using default blue for now, or match theme
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.tune, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Categories
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryChip(context, 'House', true),
                    _buildCategoryChip(context, 'Apartment', false),
                    _buildCategoryChip(context, 'Hotel', false),
                    _buildCategoryChip(context, 'Villa', false),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Featured (Nearby)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Nearby to you', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  TextButton(onPressed: () {}, child: const Text('See all', style: TextStyle(color: Colors.grey))),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 280, // Height for the card
                child: featuredAsync.when(
                  data: (apartments) {
                    if (apartments.isEmpty) return const Center(child: Text('No featured apartments'));
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      itemCount: apartments.length,
                      itemBuilder: (context, index) {
                        return PropertyCard(
                          apartment: apartments[index], 
                          onTap: () {
                             // GoRouter.of(context).push('/details/${apartments[index].id}');
                          }
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                ),
              ),
              const SizedBox(height: 24),

              // All (Best for you)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Best for you', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  TextButton(onPressed: () {}, child: const Text('See all', style: TextStyle(color: Colors.grey))),
                ],
              ),
              const SizedBox(height: 16),
              allAsync.when(
                 data: (apartments) {
                   return ListView.builder(
                     shrinkWrap: true,
                     physics: const NeverScrollableScrollPhysics(),
                     itemCount: apartments.length,
                     itemBuilder: (context, index) {
                       return Padding(
                         padding: const EdgeInsets.only(bottom: 16),
                         child: SizedBox(
                           width: double.infinity,
                           child: PropertyCard(apartment: apartments[index]),
                         ),
                       );
                     },
                   );
                 },
                 loading: () => const Center(child: CircularProgressIndicator()),
                 error: (err, stack) => const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF0A8ED9).withValues(alpha: 0.1) : Colors.white, // Light blue or white
        borderRadius: BorderRadius.circular(10),
        border: isSelected ? Border.all(color: Colors.transparent) : Border.all(color: Colors.grey[200]!),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFF0A8ED9) : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
