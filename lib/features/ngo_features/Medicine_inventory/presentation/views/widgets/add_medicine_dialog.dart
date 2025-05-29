import 'package:flutter/material.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/views/widgets/medicine_data.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/views/widgets/medicine_constants.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/views/widgets/date_validator.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/views/widgets/date_picker_field.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/widgets/medicine_form_fields.dart';

class AddMedicineDialog extends StatefulWidget {
  const AddMedicineDialog({super.key});

  @override
  State<AddMedicineDialog> createState() => _AddMedicineDialogState();
}

class _AddMedicineDialogState extends State<AddMedicineDialog> {
  final _formKey = GlobalKey<FormState>();
  final _medicineData = MedicineData();
  
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _donorInfoController = TextEditingController();
  final _notesController = TextEditingController();

  Future<void> _selectDate(BuildContext context, String dateType) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        switch (dateType) {
          case 'received':
            _medicineData.receivedDate = picked;
            break;
          case 'expiry':
            _medicineData.expiryDate = picked;
            break;
          case 'production':
            _medicineData.productionDate = picked;
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Add New Medicine',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                MedicineFormFields.buildTextField(
                  controller: _nameController,
                  label: 'Medicine Name',
                  icon: Icons.medication,
                ),
                MedicineFormFields.buildDropdown(
                  label: 'Category',
                  icon: Icons.category,
                  items: MedicineConstants.categories,
                  value: _medicineData.category,
                  onChanged: (value) =>
                      setState(() => _medicineData.category = value),
                ),
                MedicineFormFields.buildTextField(
                  controller: _quantityController,
                  label: 'Quantity Available',
                  icon: Icons.inventory,
                  isNumber: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Required';
                    if (int.tryParse(value!) == null) return 'Must be a number';
                    return null;
                  },
                ),
                DatePickerField(
                  title: 'Received Date',
                  selectedDate: _medicineData.receivedDate,
                  onTap: () => _selectDate(context, 'received'),
                  errorText: DateValidator.validateReceivedDate(
                    receivedDate: _medicineData.receivedDate,
                    expiryDate: _medicineData.expiryDate,
                    productionDate: _medicineData.productionDate,
                  ),
                ),
                const SizedBox(height: 16),
                DatePickerField(
                  title: 'Production Date',
                  selectedDate: _medicineData.productionDate,
                  onTap: () => _selectDate(context, 'production'),
                  errorText: DateValidator.validateProductionDate(
                    productionDate: _medicineData.productionDate,
                    receivedDate: _medicineData.receivedDate,
                    expiryDate: _medicineData.expiryDate,
                  ),
                ),
                const SizedBox(height: 16),
                DatePickerField(
                  title: 'Expiry Date',
                  selectedDate: _medicineData.expiryDate,
                  onTap: () => _selectDate(context, 'expiry'),
                  errorText: DateValidator.validateExpiryDate(
                    expiryDate: _medicineData.expiryDate,
                    receivedDate: _medicineData.receivedDate,
                    productionDate: _medicineData.productionDate,
                  ),
                ),
                const SizedBox(height: 16),
                MedicineFormFields.buildDropdown(
                  label: 'Status',
                  icon: Icons.info,
                  items: MedicineConstants.statuses,
                  value: _medicineData.status,
                  onChanged: (value) =>
                      setState(() => _medicineData.status = value),
                ),
                MedicineFormFields.buildTextField(
                  controller: _donorInfoController,
                  label: 'Donor Info',
                  icon: Icons.person,
                ),
                MedicineFormFields.buildDropdown(
                  label: 'Physical Condition',
                  icon: Icons.medical_information,
                  items: MedicineConstants.physicalConditions,
                  value: _medicineData.physicalCondition,
                  onChanged: (value) =>
                      setState(() => _medicineData.physicalCondition = value),
                ),
                MedicineFormFields.buildTextField(
                  controller: _notesController,
                  label: 'Notes',
                  icon: Icons.note,
                  maxLines: 3,
                  validator: null,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _handleSubmit,
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate() &&
        DateValidator.validateReceivedDate(
          receivedDate: _medicineData.receivedDate,
          expiryDate: _medicineData.expiryDate,
          productionDate: _medicineData.productionDate,
        ) == null &&
        DateValidator.validateExpiryDate(
          expiryDate: _medicineData.expiryDate,
          receivedDate: _medicineData.receivedDate,
          productionDate: _medicineData.productionDate,
        ) == null &&
        DateValidator.validateProductionDate(
          productionDate: _medicineData.productionDate,
          receivedDate: _medicineData.receivedDate,
          expiryDate: _medicineData.expiryDate,
        ) == null) {
      // TODO: Handle form submission
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _donorInfoController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
