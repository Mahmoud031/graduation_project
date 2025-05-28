import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
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
  final String medicineId;
  final String status;

  const RecievdDonationsCard({
    super.key,
    required this.medicineName,
    required this.donorName,
    required this.address,
    required this.expiryDate,
    required this.purchasedDate,
    required this.image,
    required this.medicineId,
    required this.status,
  });

  @override
  State<RecievdDonationsCard> createState() => _RecievdDonationsCardState();
}

class _RecievdDonationsCardState extends State<RecievdDonationsCard> {
  @override
  Widget build(BuildContext context) {
    final DonationStatus currentStatus = _parseStatus(widget.status);
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(currentStatus),
            const SizedBox(height: 16),
            _buildFooter(currentStatus),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(DonationStatus currentStatus) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatusIcon(status: currentStatus),
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

  Widget _buildFooter(DonationStatus currentStatus) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Expiry Date: ${widget.expiryDate}\nPurchased: ${widget.purchasedDate}',
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        StatusDropdown(
          currentStatus: currentStatus,
          onStatusChanged: (newStatus) {
            context.read<MedicineCubit>().updateMedicineStatus(
              widget.medicineId,
              newStatus.name,
            );
          },
        ),
      ],
    );
  }
}

DonationStatus _parseStatus(String status) {
  switch (status.toLowerCase()) {
    case 'approved':
      return DonationStatus.approved;
    case 'rejected':
      return DonationStatus.rejected;
    case 'delivered':
      return DonationStatus.delivered;
    case 'pending':
    default:
      return DonationStatus.pending;
  }
}
