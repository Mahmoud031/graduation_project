import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/cubits/medicine_cubit/medicine_cubit.dart';
import 'received_donations/donation_status.dart';
import 'received_donations/status_icon.dart';
import 'received_donations/status_dropdown.dart';
import 'received_donations/rejection_reason_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';

class RecievdDonationsCard extends StatefulWidget {
  final String medicineName;
  final String donorName;
  final String address;
  final String expiryDate;
  final String purchasedDate;
  final String image;
  final String medicineId;
  final String status;
  final String details;
  final String receivedDate;
  final String? rejectionMessage;
  final String userId;

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
    required this.details,
    required this.receivedDate,
    this.rejectionMessage,
    required this.userId,
  });

  @override
  State<RecievdDonationsCard> createState() => _RecievdDonationsCardState();
}

class _RecievdDonationsCardState extends State<RecievdDonationsCard> {
  void _handleStatusChange(DonationStatus newStatus) {
    if (newStatus == DonationStatus.rejected) {
      showDialog(
        context: context,
        builder: (context) => RejectionReasonDialog(
          onConfirm: (reason) {
            context.read<MedicineCubit>().updateMedicineStatus(
                  widget.medicineId,
                  newStatus.name,
                  rejectionMessage: reason,
                );
            Navigator.pop(context);
          },
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      );
    } else {
      context.read<MedicineCubit>().updateMedicineStatus(
            widget.medicineId,
            newStatus.name,
          );
    }
  }

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
            if (currentStatus == DonationStatus.rejected &&
                widget.rejectionMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rejection Reason:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.rejectionMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
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
              FutureBuilder(
                future: GetIt.I<AuthRepo>().getUserData(uId: widget.userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }
                  if (snapshot.hasError || !snapshot.hasData) {
                    return const Text(
                      'Donor phone unavailable',
                      style: TextStyle(fontSize: 14, color: Colors.red),
                    );
                  }
                  final user = snapshot.data;
                  return Text(
                    'Phone: ${user!.phone}',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  );
                },
              ),
              const SizedBox(height: 4),
              Text(
                widget.address,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 4),
              Text(
                'Details: ${widget.details}',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expiry Date: ${widget.expiryDate}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              'Purchased: ${widget.purchasedDate}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              'Received: ${widget.receivedDate}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
        StatusDropdown(
          currentStatus: currentStatus,
          onStatusChanged: _handleStatusChange,
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
