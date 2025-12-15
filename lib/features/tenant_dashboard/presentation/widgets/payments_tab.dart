import 'package:flutter/material.dart';

class PaymentsTab extends StatelessWidget {
  const PaymentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildPaymentCard(
          title: '1st Payment',
          date: '10/01/2021',
          amount: '3,000 AED',
          status: 'Paid',
          statusColor: Colors.green,
          action: null,
        ),
        _buildPaymentCard(
          title: '2nd Payment',
          date: '12/02/2021',
          amount: '2,600 AED',
          status: 'Due',
          statusColor: Colors.orange,
          action: 'Pay Now',
        ),
        _buildPaymentCard(
          title: '3rd Payment',
          date: '09/03/2021',
          amount: '3,200 AED',
          status: 'Overdue',
          statusColor: Colors.red,
          action: 'Pay Now',
        ),
        _buildPaymentCard(
          title: '4th Payment',
          date: '15/04/2021',
          amount: '2,900 AED',
          status: 'Upcoming in 23 days',
          statusColor: Colors.blue,
          action: null,
        ),
      ],
    );
  }

  Widget _buildPaymentCard({
    required String title,
    required String date,
    required String amount,
    required String status,
    required Color statusColor,
    String? action,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Rate', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(width: 8),
                      Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              if (action != null)
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Payment Method
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade50,
                    foregroundColor: Colors.blue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(action),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
