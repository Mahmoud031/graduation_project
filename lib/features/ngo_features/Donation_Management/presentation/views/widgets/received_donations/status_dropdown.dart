import 'package:flutter/material.dart';
import 'donation_status.dart';

class StatusDropdown extends StatelessWidget {
  final DonationStatus currentStatus;
  final ValueChanged<DonationStatus> onStatusChanged;

  const StatusDropdown({
    super.key,
    required this.currentStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: DonationStatusUtils.getStatusColor(currentStatus).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: DonationStatusUtils.getStatusColor(currentStatus),
          width: 1,
        ),
      ),
      child: DropdownButton<DonationStatus>(
        value: currentStatus,
        underline: const SizedBox(),
        icon: Icon(
          Icons.arrow_drop_down,
          color: DonationStatusUtils.getStatusColor(currentStatus),
        ),
        items: DonationStatus.values.map((status) {
          return DropdownMenuItem<DonationStatus>(
            value: status,
            child: Text(
              DonationStatusUtils.getStatusText(status),
              style: TextStyle(
                color: DonationStatusUtils.getStatusColor(status),
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            onStatusChanged(newValue);
          }
        },
      ),
    );
  }
} 