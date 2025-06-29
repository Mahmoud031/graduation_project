import 'package:flutter/material.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/entities/medicine_request_entity.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/repos/medicine_request_repo.dart';
import 'package:graduation_project/core/services/get_it_service.dart';

class EditNgoMedicineRequestView extends StatefulWidget {
  final MedicineRequestEntity request;
  const EditNgoMedicineRequestView({super.key, required this.request});

  @override
  State<EditNgoMedicineRequestView> createState() => _EditNgoMedicineRequestViewState();
}

class _EditNgoMedicineRequestViewState extends State<EditNgoMedicineRequestView> {
  late TextEditingController _medicineNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _quantityController;
  late TextEditingController _fulfilledQuantityController;
  String? _selectedUrgency;
  String? _selectedCategory;
  DateTime? _selectedExpiryDate;

  final List<String> _urgencyLevels = ['Low', 'Medium', 'High', 'Critical'];
  final List<String> _categories = [
    'Painkiller',
    'Antibiotic',
    'Cardiac',
    'Antiviral',
    'Antifungal',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _medicineNameController = TextEditingController(text: widget.request.medicineName);
    _descriptionController = TextEditingController(text: widget.request.description);
    _quantityController = TextEditingController(text: widget.request.quantity);
    _fulfilledQuantityController = TextEditingController(text: widget.request.fulfilledQuantity);
    _selectedUrgency = widget.request.urgency;
    _selectedCategory = widget.request.category;
    _selectedExpiryDate = widget.request.expiryDate != null ? DateTime.tryParse(widget.request.expiryDate!) : null;
  }

  @override
  void dispose() {
    _medicineNameController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _fulfilledQuantityController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final repo = getIt<MedicineRequestRepo>();
    final String fulfilledQtyStr = _fulfilledQuantityController.text.trim();
    final String qtyStr = _quantityController.text.trim();
    final int fulfilledQty = int.tryParse(fulfilledQtyStr) ?? 0;
    final int qty = int.tryParse(qtyStr) ?? 0;
    final String status = (fulfilledQty >= qty) ? 'Fulfilled' : 'Active';
    final updated = widget.request.copyWith(
      medicineName: _medicineNameController.text.trim(),
      description: _descriptionController.text.trim(),
      quantity: qtyStr,
      fulfilledQuantity: fulfilledQtyStr,
      urgency: _selectedUrgency!,
      category: _selectedCategory!,
      expiryDate: _selectedExpiryDate?.toIso8601String(),
      status: status,
    );
    await repo.updateMedicineRequest(updated);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Request updated')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Request')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _medicineNameController,
              decoration: const InputDecoration(labelText: 'Medicine Name'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _fulfilledQuantityController,
              decoration: const InputDecoration(labelText: 'Fulfilled Quantity'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedUrgency,
              items: _urgencyLevels.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => _selectedUrgency = val),
              decoration: const InputDecoration(labelText: 'Urgency'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: _categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => _selectedCategory = val),
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            const SizedBox(height: 12),
            ListTile(
              title: Text(_selectedExpiryDate == null
                  ? 'Select Expiry Date (Optional)'
                  : 'Expiry Date: ${_selectedExpiryDate!.day}/${_selectedExpiryDate!.month}/${_selectedExpiryDate!.year}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedExpiryDate ?? DateTime.now().add(const Duration(days: 1)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  setState(() => _selectedExpiryDate = picked);
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Update Request'),
            ),
          ],
        ),
      ),
    );
  }
} 