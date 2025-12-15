import 'package:flutter/material.dart';

class OwnerPaymentsTab extends StatelessWidget {
  const OwnerPaymentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildOwnerPaymentCard(
          tenantName: 'John Doe',
          unit: 'Villa No.12',
          amount: '3,000 AED',
          status: 'Paid',
          statusColor: Colors.green,
          action: 'View Receipt',
        ),
        _buildOwnerPaymentCard(
          tenantName: 'Jane Smith',
          unit: 'Apt 101',
          amount: '2,600 AED',
          status: 'Overdue',
          statusColor: Colors.red,
          action: 'Send Reminder',
        ),
      ],
    );
  }

  Widget _buildOwnerPaymentCard({
    required String tenantName,
    required String unit,
    required String amount,
    required String status,
    required Color statusColor,
    required String action,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(unit, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.person, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(tenantName, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(amount, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: Text(action)),
            ],
          ),
        ],
      ),
    );
  }
}
