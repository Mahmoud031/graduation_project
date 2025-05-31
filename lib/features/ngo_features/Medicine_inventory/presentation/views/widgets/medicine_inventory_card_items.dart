import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/views/widgets/add_medicine_widgets/date_field_widget.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/views/widgets/medicine_text_field.dart';
import 'package:graduation_project/features/donor_features/find_ngo/presentation/views/widgets/custom_home_button.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/cubit/medicine_invnetory_cubit/medicine_inventory_cubit.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/widgets/medicine_form_fields.dart';

import '../../../domain/entities/medicine_invnetory_entity.dart';

class MedicineInventoryCardItems extends StatefulWidget {
  final MedicineInvnetoryEntity medicineEntity;

  const MedicineInventoryCardItems({super.key, required this.medicineEntity});

  @override
  State<MedicineInventoryCardItems> createState() => _MedicineInventoryCardItemsState();
}

class _MedicineInventoryCardItemsState extends State<MedicineInventoryCardItems> {
  String? _dateError;

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

  void _showDeleteDialog(BuildContext context) {
    if (widget.medicineEntity.documentId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot delete: Document ID not found'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Medicine'),
        content: const Text('Are you sure you want to delete this medicine?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<MedicineInventoryCubit>().deleteMedicineInventory(widget.medicineEntity.documentId!);
              Navigator.pop(dialogContext);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    if (widget.medicineEntity.documentId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot edit: Document ID not found'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final cubit = context.read<MedicineInventoryCubit>();
    final _formKey = GlobalKey<FormState>();
    final _medicineNameController = TextEditingController(text: widget.medicineEntity.medicineName);
    final _quantityController = TextEditingController(text: widget.medicineEntity.quantityAvailable);
    final _donorInfoController = TextEditingController(text: widget.medicineEntity.donorInfo);
    final _notesController = TextEditingController(text: widget.medicineEntity.notes);

    DateTime? _receivedDate = _parseDate(widget.medicineEntity.recievedDate);
    DateTime? _expiryDate = _parseDate(widget.medicineEntity.expiryDate);
    DateTime? _productionDate = _parseDate(widget.medicineEntity.prurchasedDate);
    String? _selectedCategory = widget.medicineEntity.category;
    String? _selectedStatus = widget.medicineEntity.status;
    String? _selectedCondition = widget.medicineEntity.physicalCondition;
    setState(() {
      _dateError = null;
    });

    final List<String> _categories = [
      'Painkiller',
      'Antibiotic',
      'Cardiac',
      'Antiviral',
      'Antifungal',
      'Other'
    ];

    final List<String> _statuses = ['New', 'Opened', 'Near Expiry'];

    final List<String> _conditions = [
      'Sealed',
      'Opened',
      'Good condition',
      'Damaged'
    ];

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Edit Medicine',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  MedicineTextField(
                    labelText: 'Name',
                    hintText: 'Medicine Name',
                    prefixIcon: Icons.medication,
                    controller: _medicineNameController,
                  ),
                  const SizedBox(height: 16),
                  MedicineFormFields.buildDropdown(
                    label: 'Category',
                    icon: Icons.category,
                    items: _categories,
                    value: _selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  MedicineTextField(
                    labelText: 'Quantity',
                    hintText: 'Quantity Available',
                    prefixIcon: Icons.inventory_2,
                    controller: _quantityController,
                  ),
                  const SizedBox(height: 16),
                  DateFieldWidget(
                    labelText: 'Received Date',
                    hintText: 'Received Date',
                    icon: Icons.calendar_today,
                    isPurchasedDate: true,
                    selectedDate: _receivedDate,
                    onDateTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _receivedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        setState(() {
                          _receivedDate = date;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  DateFieldWidget(
                    labelText: 'Expiry Date',
                    hintText: 'Expiry Date',
                    icon: Icons.event_busy,
                    isPurchasedDate: false,
                    selectedDate: _expiryDate,
                    onDateTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _expiryDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        setState(() {
                          _expiryDate = date;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  DateFieldWidget(
                    labelText: 'Production Date',
                    hintText: 'Production Date',
                    icon: Icons.date_range,
                    isPurchasedDate: false,
                    selectedDate: _productionDate,
                    onDateTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _productionDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        setState(() {
                          _productionDate = date;
                        });
                      }
                    },
                  ),
                  if (_dateError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _dateError!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  MedicineFormFields.buildDropdown(
                    label: 'Status',
                    icon: Icons.info,
                    items: _statuses,
                    value: _selectedStatus,
                    onChanged: (value) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  MedicineTextField(
                    labelText: 'Donor Info',
                    hintText: 'Donor Info',
                    prefixIcon: Icons.person,
                    controller: _donorInfoController,
                  ),
                  const SizedBox(height: 16),
                  MedicineFormFields.buildDropdown(
                    label: 'Physical Condition',
                    icon: Icons.medical_services,
                    items: _conditions,
                    value: _selectedCondition,
                    onChanged: (value) {
                      setState(() {
                        _selectedCondition = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  MedicineTextField(
                    labelText: 'Notes',
                    hintText: 'Notes',
                    prefixIcon: Icons.note,
                    controller: _notesController,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: CustomHomeButton(
                      text: 'Update Medicine',
                      style: TextStyles.textstyle18,
                      onPressed: () {
                        if (_formKey.currentState!.validate() && _validateDates(_receivedDate, _expiryDate, _productionDate, setState)) {
                          _formKey.currentState!.save();
                          MedicineInvnetoryEntity updatedMedicine = MedicineInvnetoryEntity(
                            id: widget.medicineEntity.id,
                            documentId: widget.medicineEntity.documentId,
                            medicineName: _medicineNameController.text,
                            category: _selectedCategory ?? '',
                            quantityAvailable: _quantityController.text,
                            recievedDate: _receivedDate != null
                                ? '${_receivedDate!.day}/${_receivedDate!.month}/${_receivedDate!.year}'
                                : '',
                            prurchasedDate: _productionDate != null
                                ? '${_productionDate!.day}/${_productionDate!.month}/${_productionDate!.year}'
                                : '',
                            expiryDate: _expiryDate != null
                                ? '${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}'
                                : '',
                            status: _selectedStatus ?? '',
                            donorInfo: _donorInfoController.text,
                            physicalCondition: _selectedCondition ?? '',
                            notes: _notesController.text,
                          );
                          cubit.updateMedicineInventory(updatedMedicine);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTime? _parseDate(String dateStr) {
    try {
      final parts = dateStr.split('/');
      if (parts.length == 3) {
        return DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
      }
    } catch (e) {
      print('Error parsing date: $e');
    }
    return null;
  }

  bool _validateDates(DateTime? receivedDate, DateTime? expiryDate, DateTime? productionDate, StateSetter setState) {
    if (receivedDate == null) {
      setState(() {
        _dateError = 'Received date is required';
      });
      return false;
    }

    if (expiryDate == null) {
      setState(() {
        _dateError = 'Expiry date is required';
      });
      return false;
    }

    if (productionDate == null) {
      setState(() {
        _dateError = 'Production date is required';
      });
      return false;
    }

    // Check if production date is before received date
    if (productionDate.isAfter(receivedDate)) {
      setState(() {
        _dateError = 'Production date cannot be after received date';
      });
      return false;
    }

    // Check if received date is before expiry date
    if (receivedDate.isAfter(expiryDate)) {
      setState(() {
        _dateError = 'Received date cannot be after expiry date';
      });
      return false;
    }

    // Check if production date is before expiry date
    if (productionDate.isAfter(expiryDate)) {
      setState(() {
        _dateError = 'Production date cannot be after expiry date';
      });
      return false;
    }

    // Check if expiry date is in the past
    if (expiryDate.isBefore(DateTime.now())) {
      setState(() {
        _dateError = 'Expiry date cannot be in the past';
      });
      return false;
    }

    setState(() {
      _dateError = null;
    });
    return true;
  }

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
                            color: _getStatusColor(widget.medicineEntity.status).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _getStatusColor(widget.medicineEntity.status).withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            widget.medicineEntity.status,
                            style: TextStyle(
                              color: _getStatusColor(widget.medicineEntity.status),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                          onPressed: () => _showEditDialog(context),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => _showDeleteDialog(context),
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
                          child: _buildInfoItem(
                            icon: Icons.category,
                            label: 'Category',
                            value: widget.medicineEntity.category,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildInfoItem(
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
                          _buildDateRow(
                            'Received Date',
                            widget.medicineEntity.recievedDate,
                            Icons.calendar_today,
                          ),
                          const Divider(height: 16),
                          _buildDateRow(
                            'Purchased Date',
                            widget.medicineEntity.prurchasedDate,
                            Icons.shopping_cart,
                          ),
                          const Divider(height: 16),
                          _buildDateRow(
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
                      _buildInfoItem(
                        icon: Icons.person,
                        label: 'Donor Info',
                        value: widget.medicineEntity.donorInfo,
                      ),
                    if (widget.medicineEntity.donorInfo.isNotEmpty) const SizedBox(height: 12),
                    if (widget.medicineEntity.notes.isNotEmpty)
                      _buildInfoItem(
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
