import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/views/widgets/medicine_text_field.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/views/widgets/add_medicine_widgets/date_field_widget.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/domain/entities/medicine_invnetory_entity.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/cubit/add_medicine_to_inventory_cubit/add_medicine_to_inventory_cubit.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/widgets/medicine_form_fields.dart';
import '../../../../../donor_features/find_ngo/presentation/views/widgets/custom_home_button.dart';

class AddMedicineDialog extends StatefulWidget {
  const AddMedicineDialog({super.key});
  
  @override
  State<AddMedicineDialog> createState() => _AddMedicineDialogState();
}

class _AddMedicineDialogState extends State<AddMedicineDialog> {
  final _formKey = GlobalKey<FormState>();
  final _medicineNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _donorInfoController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime? _receivedDate;
  DateTime? _expiryDate;
  DateTime? _productionDate;
  String? _selectedCategory;
  String? _selectedStatus;
  String? _selectedCondition;
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

  @override
  void dispose() {
    _medicineNameController.dispose();
    _quantityController.dispose();
    _donorInfoController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  bool _validateDates() {
    if (_receivedDate == null) {
      setState(() {
        _dateError = 'Received date is required';
      });
      return false;
    }

    if (_expiryDate == null) {
      setState(() {
        _dateError = 'Expiry date is required';
      });
      return false;
    }

    if (_productionDate == null) {
      setState(() {
        _dateError = 'Production date is required';
      });
      return false;
    }

    // Check if production date is before received date
    if (_productionDate!.isAfter(_receivedDate!)) {
      setState(() {
        _dateError = 'Production date cannot be after received date';
      });
      return false;
    }

    // Check if received date is before expiry date
    if (_receivedDate!.isAfter(_expiryDate!)) {
      setState(() {
        _dateError = 'Received date cannot be after expiry date';
      });
      return false;
    }

    // Check if production date is before expiry date
    if (_productionDate!.isAfter(_expiryDate!)) {
      setState(() {
        _dateError = 'Production date cannot be after expiry date';
      });
      return false;
    }

    // Check if expiry date is in the past
    if (_expiryDate!.isBefore(DateTime.now())) {
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

  Future<void> _selectDate(BuildContext context, bool isReceivedDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isReceivedDate) {
          _receivedDate = picked;
        } else {
          _expiryDate = picked;
        }
        // Validate dates after selection
        _validateDates();
      });
    }
  }

  Future<void> _selectProductionDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _productionDate = picked;
        // Validate dates after selection
        _validateDates();
      });
    }
  }

  String quantity = '', medicineName = '', donorInfo = '', notes = '';
  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                    'Add New Medicine',
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
                onSaved: (value) {
                  medicineName = value ?? '';
                },
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
                onSaved: (value) {
                  quantity = value ?? '';
                },
              ),
              const SizedBox(height: 16),
              DateFieldWidget(
                labelText: 'Received Date',
                hintText: 'Received Date',
                icon: Icons.calendar_today,
                isPurchasedDate: true,
                selectedDate: _receivedDate,
                onDateTap: () => _selectDate(context, true),
              ),
              const SizedBox(height: 16),
              DateFieldWidget(
                labelText: 'Expiry Date',
                hintText: 'Expiry Date',
                icon: Icons.event_busy,
                isPurchasedDate: false,
                selectedDate: _expiryDate,
                onDateTap: () => _selectDate(context, false),
              ),
              const SizedBox(height: 16),
              DateFieldWidget(
                labelText: 'Production Date',
                hintText: 'Production Date',
                icon: Icons.date_range,
                isPurchasedDate: false,
                selectedDate: _productionDate,
                onDateTap: () => _selectProductionDate(context),
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
                onSaved: (value) {
                  donorInfo = value ?? '';
                },
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
                onSaved: (value) {
                  notes = value ?? '';
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: CustomHomeButton(
                  text: 'Add Medicine',
                  style: TextStyles.textstyle18,
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _validateDates()) {
                      _formKey.currentState!.save();
                      final cubit = context.read<AddMedicineToInventoryCubit>();
                      MedicineInvnetoryEntity input = MedicineInvnetoryEntity(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        medicineName: medicineName,
                        category: _selectedCategory ?? '',
                        quantityAvailable: quantity,
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
                        donorInfo: donorInfo,
                        physicalCondition: _selectedCondition ?? '',
                        notes: notes,
                      );
                      cubit.addMedicineToInventory(input);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
