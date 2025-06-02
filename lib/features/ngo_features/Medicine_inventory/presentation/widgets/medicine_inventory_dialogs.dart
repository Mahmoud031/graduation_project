import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/views/widgets/add_medicine_widgets/date_field_widget.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/views/widgets/medicine_text_field.dart';
import 'package:graduation_project/features/donor_features/find_ngo/presentation/views/widgets/custom_home_button.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/cubit/medicine_invnetory_cubit/medicine_inventory_cubit.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/utils/medicine_inventory_utils.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/widgets/medicine_form_fields.dart';
import '../../domain/entities/medicine_invnetory_entity.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';

class MedicineInventoryDialogs {
  static void showDeleteDialog(BuildContext context, MedicineInvnetoryEntity medicineEntity) {
    if (medicineEntity.documentId == null) {
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
              context.read<MedicineInventoryCubit>().deleteMedicineInventory(medicineEntity.documentId!);
              Navigator.pop(dialogContext);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  static void showEditDialog(BuildContext context, MedicineInvnetoryEntity medicineEntity) {
    if (medicineEntity.documentId == null) {
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
    final _medicineNameController = TextEditingController(text: medicineEntity.medicineName);
    final _quantityController = TextEditingController(text: medicineEntity.quantityAvailable);
    final _donorInfoController = TextEditingController(text: medicineEntity.donorInfo);
    final _notesController = TextEditingController(text: medicineEntity.notes);

    DateTime? _receivedDate = MedicineInventoryUtils.parseDate(medicineEntity.recievedDate);
    DateTime? _expiryDate = MedicineInventoryUtils.parseDate(medicineEntity.expiryDate);
    DateTime? _productionDate = MedicineInventoryUtils.parseDate(medicineEntity.prurchasedDate);
    String? _selectedCategory = medicineEntity.category;
    String? _selectedStatus = medicineEntity.status;
    String? _selectedCondition = medicineEntity.physicalCondition;
    String? _dateError;

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
                        if (_formKey.currentState!.validate() && 
                            MedicineInventoryUtils.validateDates(_receivedDate, _expiryDate, _productionDate, (error) {
                              setState(() {
                                _dateError = error;
                              });
                            })) {
                          _formKey.currentState!.save();
                          MedicineInvnetoryEntity updatedMedicine = MedicineInvnetoryEntity(
                            id: medicineEntity.id,
                            documentId: medicineEntity.documentId,
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
                            ngoUId: getNgo().uId,
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
} 