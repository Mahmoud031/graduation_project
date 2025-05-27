import 'package:flutter/material.dart';
import 'received_donations/donation_status.dart';
import 'received_donations/status_icon.dart';
import 'received_donations/status_dropdown.dart';

class RecievdDonationsCard extends StatefulWidget {
  final String medicineName;
  final String donorName;
  final String address;
  final String expiryDate;
  final String purchasedDate;
  final String image;

  const RecievdDonationsCard({
    super.key,
    required this.medicineName,
    required this.donorName,
    required this.address,
    required this.expiryDate,
    required this.purchasedDate,
    required this.image,
  });

  @override
  State<RecievdDonationsCard> createState() => _RecievdDonationsCardState();
}

class _RecievdDonationsCardState extends State<RecievdDonationsCard> {
  DonationStatus _currentStatus = DonationStatus.pending;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildFooter(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatusIcon(status: _currentStatus),
        const SizedBox(width: 16),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.medicineName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Donor: ${widget.donorName}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.address,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            widget.image,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 80,
                height: 80,
                color: Colors.grey[300],
                child: const Icon(Icons.error_outline, color: Colors.grey),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expiry Date: ${widget.expiryDate}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 4),
            Text(
              'Purchased: ${widget.purchasedDate}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
        StatusDropdown(
          currentStatus: _currentStatus,
          onStatusChanged: (newStatus) {
            setState(() => _currentStatus = newStatus);
          },
        ),
      ],
    );
  }
}
