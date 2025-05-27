import 'package:flutter/material.dart';

enum DonationStatus {
  pending,
  approved,
  rejected,
  delivered,
}

class DonationStatusUtils {
  static Color getStatusColor(DonationStatus status) {
    switch (status) {
      case DonationStatus.pending:
        return Colors.orange;
      case DonationStatus.approved:
        return Colors.green;
      case DonationStatus.rejected:
        return Colors.red;
      case DonationStatus.delivered:
        return Colors.blue;
    }
  }

  static IconData getStatusIcon(DonationStatus status) {
    switch (status) {
      case DonationStatus.pending:
        return Icons.pending_actions;
      case DonationStatus.approved:
        return Icons.check_circle;
      case DonationStatus.rejected:
        return Icons.cancel;
      case DonationStatus.delivered:
        return Icons.local_shipping;
    }
  }

  static String getStatusText(DonationStatus status) {
    switch (status) {
      case DonationStatus.pending:
        return 'Pending';
      case DonationStatus.approved:
        return 'Approved';
      case DonationStatus.rejected:
        return 'Rejected';
      case DonationStatus.delivered:
        return 'Delivered';
    }
  }
} 