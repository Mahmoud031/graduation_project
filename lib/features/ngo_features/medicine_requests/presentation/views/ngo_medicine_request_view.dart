import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/domain/entities/medicine_request_entity.dart';
import 'package:graduation_project/features/ngo_features/medicine_requests/presentation/cubits/create_request_cubit/create_request_cubit.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';

class NgoMedicineRequestView extends StatefulWidget {
  static const routeName = 'ngoMedicineRequest';
  const NgoMedicineRequestView({super.key});

  @override
  State<NgoMedicineRequestView> createState() => _NgoMedicineRequestViewState();
}

class _NgoMedicineRequestViewState extends State<NgoMedicineRequestView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _medicineNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateRequestCubit(getIt()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Request Medicine')),
        body: BlocConsumer<CreateRequestCubit, CreateRequestState>(
          listener: (context, state) {
            if (state is CreateRequestSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Request submitted successfully!')),
              );
              _formKey.currentState?.reset();
              _medicineNameController.clear();
              _descriptionController.clear();
              _quantityController.clear();
              setState(() {
                _selectedUrgency = null;
                _selectedCategory = null;
              });
            } else if (state is CreateRequestFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _medicineNameController,
                      decoration: const InputDecoration(labelText: 'Medicine Name'),
                      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
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
                      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _selectedUrgency,
                      items: _urgencyLevels.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      onChanged: (val) => setState(() => _selectedUrgency = val),
                      decoration: const InputDecoration(labelText: 'Urgency'),
                      validator: (value) => value == null ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      items: _categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      onChanged: (val) => setState(() => _selectedCategory = val),
                      decoration: const InputDecoration(labelText: 'Category'),
                      validator: (value) => value == null ? 'Required' : null,
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
                          initialDate: DateTime.now().add(const Duration(days: 1)),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null) {
                          setState(() => _selectedExpiryDate = picked);
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    state is CreateRequestLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final ngo = getNgo();
                                final now = DateTime.now();
                                final request = MedicineRequestEntity(
                                  id: now.millisecondsSinceEpoch.toString(),
                                  medicineName: _medicineNameController.text.trim(),
                                  description: _descriptionController.text.trim(),
                                  quantity: _quantityController.text.trim(),
                                  urgency: _selectedUrgency!,
                                  ngoName: ngo.name,
                                  ngoUId: ngo.uId,
                                  requestDate: now.toIso8601String(),
                                  status: 'Active',
                                  category: _selectedCategory!,
                                  expiryDate: _selectedExpiryDate?.toIso8601String(),
                                );
                                context.read<CreateRequestCubit>().createRequest(request);
                              }
                            },
                            child: const Text('Submit Request'),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
} 