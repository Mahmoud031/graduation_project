import 'package:flutter/material.dart';

class AddMedicineDialog extends StatefulWidget {
  const AddMedicineDialog({super.key});

  @override
  State<AddMedicineDialog> createState() => _AddMedicineDialogState();
}

class _AddMedicineDialogState extends State<AddMedicineDialog> {
  final TextEditingController _medicineNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _donorInfoController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime? _receivedDate;
  DateTime? _expiryDate;
  DateTime? _productionDate;
  String? _selectedCategory;
  String? _selectedStatus;
  String? _selectedPhysicalCondition;

  final List<String> _categories = [
    'Painkiller',
    'Antibiotic',
    'Cardiac',
    'Antiviral',
    'Antifungal',
    'Antihistamine',
    'Antacid',
    'Other'
  ];

  final List<String> _statuses = [
    'New',
    'Opened',
    'Near Expiry',
    'Expired',
    'Damaged'
  ];

  final List<String> _physicalConditions = [
    'Sealed',
    'Opened',
    'Good condition',
    'Damaged',
    'Partially used'
  ];

  Future<void> _selectDate(BuildContext context, bool isReceivedDate, bool isExpiryDate) async {
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
        } else if (isExpiryDate) {
          _expiryDate = picked;
        } else {
          _productionDate = picked;
        }
      });
    }
  }

  @override
  void dispose() {
    _medicineNameController.dispose();
    _quantityController.dispose();
    _donorInfoController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Medicine'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _medicineNameController,
              decoration: const InputDecoration(
                labelText: 'Medicine Name',
                hintText: 'e.g., Paracetamol 500mg',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.medication),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity Available',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.inventory),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Received Date',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.calendar_today),
                hintText: _receivedDate != null
                    ? '${_receivedDate!.day}/${_receivedDate!.month}/${_receivedDate!.year}'
                    : 'Select Date',
              ),
              readOnly: true,
              onTap: () => _selectDate(context, true, false),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Expiry Date',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.event_busy),
                hintText: _expiryDate != null
                    ? '${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}'
                    : 'Select Date',
              ),
              readOnly: true,
              onTap: () => _selectDate(context, false, true),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Production Date',
                hintText: _productionDate != null
                    ? '${_productionDate!.day}/${_productionDate!.month}/${_productionDate!.year}'
                    : 'Optional - Select Date',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.date_range),
              ),
              readOnly: true,
              onTap: () => _selectDate(context, false, false),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.info),
              ),
              items: _statuses.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStatus = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _donorInfoController,
              decoration: const InputDecoration(
                labelText: 'Donor Info',
                hintText: 'Name or ID of the donor',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedPhysicalCondition,
              decoration: const InputDecoration(
                labelText: 'Physical Condition',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.check_circle),
              ),
              items: _physicalConditions.map((String condition) {
                return DropdownMenuItem<String>(
                  value: condition,
                  child: Text(condition),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPhysicalCondition = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Notes',
                hintText: 'Example: "Donated without box"',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note),
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement save functionality with the form data
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
} 