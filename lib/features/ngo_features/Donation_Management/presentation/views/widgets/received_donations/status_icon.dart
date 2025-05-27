import 'package:flutter/material.dart';
import 'donation_status.dart';

class StatusIcon extends StatelessWidget {
  final DonationStatus status;

  const StatusIcon({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: DonationStatusUtils.getStatusColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        DonationStatusUtils.getStatusIcon(status),
        color: DonationStatusUtils.getStatusColor(status),
        size: 32,
      ),
    );
  }
} 