import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/payments_tab.dart';
import '../widgets/maintenance_tab.dart';
import '../widgets/documents_tab.dart';

class TenantPropertyManagementScreen extends ConsumerStatefulWidget {
  final String apartmentId;

  const TenantPropertyManagementScreen({super.key, required this.apartmentId});

  @override
  ConsumerState<TenantPropertyManagementScreen> createState() => _TenantPropertyManagementScreenState();
}

class _TenantPropertyManagementScreenState extends ConsumerState<TenantPropertyManagementScreen> with SingleTickerProviderStateMixin {
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
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/apartment_4.webp', // Mock
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Villa No.12 - 55 B Street',
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Old Dubai Hwy No 12',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.grey),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF0A3D62),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF0A3D62),
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
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
          PaymentsTab(),
          MaintenanceTab(),
          DocumentsTab(),
        ],
      ),
    );
  }
}
