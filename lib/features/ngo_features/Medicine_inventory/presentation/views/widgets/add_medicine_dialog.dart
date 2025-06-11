import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/domain/entities/medicine_invnetory_entity.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/cubit/add_medicine_to_inventory_cubit/add_medicine_to_inventory_cubit.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/utils/medicine_inventory_utils.dart';
import 'package:graduation_project/features/ngo_features/Medicine_inventory/presentation/widgets/add_medicine_dialog_widgets.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';

import '../../cubit/medicine_invnetory_cubit/medicine_inventory_cubit.dart';

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

  String quantity = '', medicineName = '', donorInfo = '', notes = '';

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

  bool _validateDates() {
    return MedicineInventoryUtils.validateDates(
      _receivedDate,
      _expiryDate,
      _productionDate,
      (error) {
        setState(() {
          _dateError = error;
        });
      },
    );
  }

  void _handleAddMedicine(BuildContext context) {
    if (_formKey.currentState!.validate() && _validateDates()) {
      _formKey.currentState!.save();
      final cubit = context.read<AddMedicineToInventoryCubit>();
      final ngo = getNgo();
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
        ngoUId: ngo.uId,
      );
      cubit.addMedicineToInventory(input);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddMedicineToInventoryCubit, AddMedicineToInventoryState>(
      listener: (context, state) async {
        if (state is AddMedicineToInventorySuccess) {
        
          
          // Then refresh the medicine inventory list
          await Future.delayed(const Duration(milliseconds: 500));
          if (context.mounted) {
            context.read<MedicineInventoryCubit>().getMedicineInventory();
            
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Medicine added successfully'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          }
        } else if (state is AddMedicineToInventoryFailure) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: AddMedicineDialogWidgets.buildDialogContent(
          formKey: _formKey,
          medicineNameController: _medicineNameController,
          quantityController: _quantityController,
          donorInfoController: _donorInfoController,
          notesController: _notesController,
          receivedDate: _receivedDate,
          expiryDate: _expiryDate,
          productionDate: _productionDate,
          selectedCategory: _selectedCategory,
          selectedStatus: _selectedStatus,
          selectedCondition: _selectedCondition,
          dateError: _dateError,
          categories: _categories,
          statuses: _statuses,
          conditions: _conditions,
          onCategoryChanged: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
          onStatusChanged: (value) {
            setState(() {
              _selectedStatus = value;
            });
          },
          onConditionChanged: (value) {
            setState(() {
              _selectedCondition = value;
            });
          },
          onReceivedDateTap: () => _selectDate(context, true),
          onExpiryDateTap: () => _selectDate(context, false),
          onProductionDateTap: () => _selectProductionDate(context),
          onMedicineNameSaved: (value) {
            medicineName = value ?? '';
          },
          onQuantitySaved: (value) {
            quantity = value ?? '';
          },
          onDonorInfoSaved: (value) {
            donorInfo = value ?? '';
          },
          onNotesSaved: (value) {
            notes = value ?? '';
          },
          onAddPressed: () => _handleAddMedicine(context),
          context: context,
        ),
      ),
    );
  }
}
