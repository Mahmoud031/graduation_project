import 'package:flutter/material.dart';

class MedicineCard extends StatelessWidget {
  final String name;
  final String type;
  final int stock;
  final String expiry;
  final String donor;
  final String received;
  final String condition;
  final bool isExpiryWarning;
  final VoidCallback? onView;
  final VoidCallback? onEdit;

  const MedicineCard({
    required this.name,
    required this.type,
    required this.stock,
    required this.expiry,
    required this.donor,
    required this.received,
    required this.condition,
    this.isExpiryWarning = false,
    this.onView,
    this.onEdit,
    Key? key,
  }) : super(key: key);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    if (onView != null)
                      IconButton(
                        icon: const Icon(Icons.remove_red_eye_outlined),
                        onPressed: onView,
                        tooltip: 'View',
                      ),
                    if (onEdit != null)
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: onEdit,
                        tooltip: 'Edit',
                      ),
                  ],
                ),
              ],
            ),
            Text(
              type,
              style: const TextStyle(fontSize: 15, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Stock: $stock Units'),
                const Spacer(),
                if (isExpiryWarning)
                  const Icon(Icons.warning, color: Colors.red, size: 18),
                Text(
                  'Expiry: $expiry',
                  style: TextStyle(
                    color: isExpiryWarning ? Colors.red : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('Donor $donor'),
                const Spacer(),
                Text('Received: $received'),
              ],
            ),
            const SizedBox(height: 4),
            Text('Condition: $condition'),
          ],
        ),
      ),
    );
  }
} 