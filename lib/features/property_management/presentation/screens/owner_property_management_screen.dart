import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:apartment_rental/features/property_listing/presentation/providers/property_providers.dart';
import '../widgets/owner/owner_payments_tab.dart';
import '../widgets/owner/owner_maintenance_tab.dart';
import '../widgets/owner/owner_documents_tab.dart';

class OwnerPropertyManagementScreen extends ConsumerStatefulWidget {
  final String apartmentId;

  const OwnerPropertyManagementScreen({super.key, required this.apartmentId});

  @override
  ConsumerState<OwnerPropertyManagementScreen> createState() => _OwnerPropertyManagementScreenState();
}

class _OwnerPropertyManagementScreenState extends ConsumerState<OwnerPropertyManagementScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the specific apartment to pass to the edit screen
    final apartmentAsync = ref.watch(allApartmentsProvider).whenData(
          (apartments) => apartments.firstWhere((apt) => apt.id == widget.apartmentId),
        );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Property Management', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        actions: [
          apartmentAsync.when(
            data: (apartment) => IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                context.push('/edit_property/${widget.apartmentId}', extra: apartment);
              },
            ),
            loading: () => const SizedBox.shrink(),
            error: (e, s) => const SizedBox.shrink(),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFFE85D32),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFFE85D32),
          tabs: const [
            Tab(text: 'Payments'),
            Tab(text: 'Maintenance'),
            Tab(text: 'Documents'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          OwnerPaymentsTab(),
          OwnerMaintenanceTab(),
          OwnerDocumentsTab(),
        ],
      ),
    );
  }
}
