import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';

import '../../../domain/entities/medicine_invnetory_entity.dart';

class MedicineInventoryCardItems extends StatelessWidget {
  final MedicineInvnetoryEntity medicineEntity;

  const MedicineInventoryCardItems({super.key, required this.medicineEntity});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.green;
      case 'opened':
        return Colors.orange;
      case 'near expiry':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section with Medicine Name and Status
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    medicineEntity.medicineName,
                    style: TextStyles.textstyle18.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(medicineEntity.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _getStatusColor(medicineEntity.status).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    medicineEntity.status,
                    style: TextStyle(
                      color: _getStatusColor(medicineEntity.status),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category and Quantity Row
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        icon: Icons.category,
                        label: 'Category',
                        value: medicineEntity.category,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildInfoItem(
                        icon: Icons.inventory_2,
                        label: 'Quantity',
                        value: medicineEntity.quantityAvailable,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Dates Section
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildDateRow(
                        'Received Date',
                        medicineEntity.recievedDate,
                        Icons.calendar_today,
                      ),
                      const Divider(height: 16),
                      _buildDateRow(
                        'Purchased Date',
                        medicineEntity.prurchasedDate,
                        Icons.shopping_cart,
                      ),
                      const Divider(height: 16),
                      _buildDateRow(
                        'Expiry Date',
                        medicineEntity.expiryDate,
                        Icons.event_busy,
                        isExpiry: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Donor Info and Notes
                if (medicineEntity.donorInfo.isNotEmpty)
                  _buildInfoItem(
                    icon: Icons.person,
                    label: 'Donor Info',
                    value: medicineEntity.donorInfo,
                  ),
                if (medicineEntity.donorInfo.isNotEmpty) const SizedBox(height: 12),
                if (medicineEntity.notes.isNotEmpty)
                  _buildInfoItem(
                    icon: Icons.note,
                    label: 'Notes',
                    value: medicineEntity.notes,
                    maxLines: 2,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey.shade600),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyles.textstyle14.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyles.textstyle14.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildDateRow(String label, String date, IconData icon, {bool isExpiry = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyles.textstyle14.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          date,
          style: TextStyles.textstyle14.copyWith(
            color: isExpiry ? Colors.red : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
