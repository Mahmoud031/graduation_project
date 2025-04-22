import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_app_bar.dart';
import 'package:graduation_project/features/home/presentation/services/medicine_form_service.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/medicine_text_field.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/custom_home_button.dart';

class AddNewMedicineViewBody extends StatefulWidget {
  const AddNewMedicineViewBody({super.key});

  @override
  State<AddNewMedicineViewBody> createState() => _AddNewMedicineViewBodyState();
}

class _AddNewMedicineViewBodyState extends State<AddNewMedicineViewBody> {
  // Controllers
  final TextEditingController _medicineNameController = TextEditingController();
  final TextEditingController _tabletCountController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  // Service
  final MedicineFormService _formService = MedicineFormService();

  @override
  void dispose() {
    _medicineNameController.dispose();
    _tabletCountController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  Widget _buildDateField({
    required String hintText,
    required IconData icon,
    required bool isPurchasedDate,
  }) {
    return MedicineTextField(
      hintText: hintText,
      prefixIcon: icon,
      isDateField: true,
      selectedDate: isPurchasedDate ? _formService.purchasedDate : _formService.expiryDate,
      onDateTap: () async {
        await _formService.selectDate(context, isPurchasedDate);
        setState(() {});
      },
      controller: TextEditingController(),
    );
  }

  Widget _buildExpiryError() {
    if (_formService.expiryError == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 8.0),
      child: Text(
        _formService.expiryError!,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(
            title: 'Add New Medicine',
          ),
          const SizedBox(height: 20),
          MedicineTextField(
            hintText: 'Medicine Name',
            prefixIcon: Icons.medication,
            controller: _medicineNameController,
          ),
          const SizedBox(height: 16),
          MedicineTextField(
            hintText: 'Tablet Count',
            prefixIcon: Icons.numbers,
            keyboardType: TextInputType.number,
            controller: _tabletCountController,
          ),
          const SizedBox(height: 16),
          _buildDateField(
            hintText: 'Purchased Date',
            icon: Icons.calendar_month_outlined,
            isPurchasedDate: true,
          ),
          const SizedBox(height: 16),
          _buildDateField(
            hintText: 'Expiry Date',
            icon: Icons.event_busy_outlined,
            isPurchasedDate: false,
          ),
          _buildExpiryError(),
          const SizedBox(height: 16),
          MedicineTextField(
            hintText: 'Details',
            prefixIcon: Icons.description,
            maxLines: 3,
            controller: _detailsController,
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomHomeButton(
                text: 'Add Medicine',
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
