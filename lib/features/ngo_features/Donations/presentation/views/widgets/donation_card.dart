import 'package:flutter/material.dart';

class DonationCard extends StatelessWidget {
  final String title;
  final String id;
  final String status;
  final IconData statusIcon;
  final Color statusColor;
  final String donor;
  final String date;
  final String? location;
  const DonationCard({
    required this.title,
    required this.id,
    required this.status,
    required this.statusIcon,
    required this.statusColor,
    required this.donor,
    required this.date,
    this.location,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.badge, size: 18, color: Colors.red[400]),
                const SizedBox(width: 4),
                Text('ID: $id'),
                const SizedBox(width: 12),
                Icon(statusIcon, size: 18, color: statusColor),
                const SizedBox(width: 4),
                Text('Status: $status'),
                const SizedBox(width: 12),
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(date),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person, size: 18, color: Colors.black54),
                const SizedBox(width: 4),
                Text('Donor: $donor'),
              ],
            ),
            if (location != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 18, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text(location!),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
} 