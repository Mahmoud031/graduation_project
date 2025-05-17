import 'package:flutter/material.dart';

class ShipmentCard extends StatelessWidget {
  final String shipmentNumber;
  final String location;
  final String dateTime;
  final String status;
  final IconData icon;
  final Color iconColor;
  final Color statusColor;

  const ShipmentCard({
    required this.shipmentNumber,
    required this.location,
    required this.dateTime,
    required this.status,
    required this.icon,
    required this.iconColor,
    required this.statusColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shipmentNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    location,
                    style: const TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                  Text(
                    dateTime,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 