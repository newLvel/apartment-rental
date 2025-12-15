import 'package:flutter/material.dart';

class MaintenanceTab extends StatelessWidget {
  const MaintenanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTicket(
          id: 'MS0213',
          date: '10/01/2021',
          status: 'Solved',
          statusColor: Colors.green,
          hasUpdate: true,
        ),
        _buildTicket(
          id: 'MS0481',
          date: '12/02/2021',
          status: 'In Progress',
          statusColor: Colors.orange,
          hasUpdate: false,
        ),
        _buildTicket(
          id: 'MS0244',
          date: '09/03/2021',
          status: 'Submitted',
          statusColor: Colors.blue,
          subtext: 'waiting tenant feedback',
          hasUpdate: false,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () {
               // Create Request
            },
            icon: const Icon(Icons.add_circle_outline),
            label: const Text('Create Request'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A3D62),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTicket({
    required String id,
    required String date,
    required String status,
    required Color statusColor,
    String? subtext,
    required bool hasUpdate,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(id, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  if (hasUpdate)
                   Container(
                     margin: const EdgeInsets.only(left: 4),
                     width: 6, height: 6,
                     decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                   )
                ],
              ),
              Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
          if (subtext != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(subtext, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ),
        ],
      ),
    );
  }
}
