import 'package:flutter/material.dart';

class OwnerMaintenanceTab extends StatefulWidget {
  const OwnerMaintenanceTab({super.key});

  @override
  State<OwnerMaintenanceTab> createState() => _OwnerMaintenanceTabState();
}

class _OwnerMaintenanceTabState extends State<OwnerMaintenanceTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTicket(
          id: 'MS0213',
          unit: 'Villa No.12',
          issue: 'AC not cooling',
          status: 'In Progress',
          statusColor: Colors.orange,
        ),
        _buildTicket(
          id: 'MS0481',
          unit: 'Apt 101',
          issue: 'Leaking Faucet',
          status: 'Pending',
          statusColor: Colors.red,
        ),
      ],
    );
  }

  Widget _buildTicket({
    required String id,
    required String unit,
    required String issue,
    required String status,
    required Color statusColor,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(id, style: const TextStyle(fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                value: status,
                isDense: true,
                style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
                underline: Container(),
                items: ['Pending', 'In Progress', 'Solved'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  // Update status logic
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(unit, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 12),
          Text(issue, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {}, 
                child: const Text('Assign Crew')
              ),
            ],
          ),
        ],
      ),
    );
  }
}
