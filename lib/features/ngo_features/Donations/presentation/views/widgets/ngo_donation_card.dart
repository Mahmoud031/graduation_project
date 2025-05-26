import 'package:flutter/material.dart';

class NgoDonationCard extends StatelessWidget {
  final String medicineName;
  final String donorName;
  final String status;
  final IconData statusIcon;
  final Color statusColor;
  final String tabletCount;
  final String purchasedDate;
  final String expirtDate;
  final String details;
  final String? image;
  final String? location;
  const NgoDonationCard({
    required this.medicineName,
    required this.donorName,
    required this.status,
    required this.statusIcon,
    required this.statusColor,
    required this.tabletCount,
    required this.purchasedDate,
    this.location,
    super.key,
    required this.expirtDate,
    required this.details,
    this.image,
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
              medicineName,
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
                Text('name: $donorName'),
                const SizedBox(width: 12),
                Icon(statusIcon, size: 18, color: statusColor),
                const SizedBox(width: 4),
                Text('Status: $status'),
                const SizedBox(width: 12),
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text('purchased: $purchasedDate'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person, size: 18, color: Colors.black54),
                const SizedBox(width: 4),
                Text('Tablets: $tabletCount'),
                const SizedBox(width: 12),
                Icon(Icons.date_range, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text('Expiry: $expirtDate'),
              ],
            ),
            if (location != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on,
                      size: 18, color: Colors.black54),
                  const SizedBox(width: 4),
                  Text(location!),
                  SizedBox(width: 12),
                  Image.network(
                    image ?? '',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ],
            const SizedBox(height: 8),
            Text(
              'Details: $details',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
