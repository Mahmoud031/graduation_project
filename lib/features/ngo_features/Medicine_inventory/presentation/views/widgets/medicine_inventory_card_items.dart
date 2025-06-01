import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/cubit/medicine_invnetory_cubit/medicine_inventory_cubit.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/utils/medicine_inventory_utils.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/widgets/medicine_inventory_card_widgets.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/widgets/medicine_inventory_dialogs.dart';

import '../../../domain/entities/medicine_invnetory_entity.dart';

class MedicineInventoryCardItems extends StatefulWidget {
  final MedicineInvnetoryEntity medicineEntity;

  const MedicineInventoryCardItems({super.key, required this.medicineEntity});

  @override
  State<MedicineInventoryCardItems> createState() => _MedicineInventoryCardItemsState();
}

class _MedicineInventoryCardItemsState extends State<MedicineInventoryCardItems> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicineInventoryCubit, MedicineInventoryState>(
      builder: (context, state) {
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
                        widget.medicineEntity.medicineName,
                        style: TextStyles.textstyle18.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: MedicineInventoryUtils.getStatusColor(widget.medicineEntity.status).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: MedicineInventoryUtils.getStatusColor(widget.medicineEntity.status).withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            widget.medicineEntity.status,
                            style: TextStyle(
                              color: MedicineInventoryUtils.getStatusColor(widget.medicineEntity.status),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                          onPressed: () => MedicineInventoryDialogs.showEditDialog(context, widget.medicineEntity),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => MedicineInventoryDialogs.showDeleteDialog(context, widget.medicineEntity),
                        ),
                      ],
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
                          child: MedicineInventoryCardWidgets.buildInfoItem(
                            icon: Icons.category,
                            label: 'Category',
                            value: widget.medicineEntity.category,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: MedicineInventoryCardWidgets.buildInfoItem(
                            icon: Icons.inventory_2,
                            label: 'Quantity',
                            value: widget.medicineEntity.quantityAvailable,
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
                          MedicineInventoryCardWidgets.buildDateRow(
                            'Received Date',
                            widget.medicineEntity.recievedDate,
                            Icons.calendar_today,
                          ),
                          const Divider(height: 16),
                          MedicineInventoryCardWidgets.buildDateRow(
                            'Purchased Date',
                            widget.medicineEntity.prurchasedDate,
                            Icons.shopping_cart,
                          ),
                          const Divider(height: 16),
                          MedicineInventoryCardWidgets.buildDateRow(
                            'Expiry Date',
                            widget.medicineEntity.expiryDate,
                            Icons.event_busy,
                            isExpiry: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Donor Info and Notes
                    if (widget.medicineEntity.donorInfo.isNotEmpty)
                      MedicineInventoryCardWidgets.buildInfoItem(
                        icon: Icons.person,
                        label: 'Donor Info',
                        value: widget.medicineEntity.donorInfo,
                      ),
                    if (widget.medicineEntity.donorInfo.isNotEmpty) const SizedBox(height: 12),
                    if (widget.medicineEntity.notes.isNotEmpty)
                      MedicineInventoryCardWidgets.buildInfoItem(
                        icon: Icons.note,
                        label: 'Notes',
                        value: widget.medicineEntity.notes,
                        maxLines: 2,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
