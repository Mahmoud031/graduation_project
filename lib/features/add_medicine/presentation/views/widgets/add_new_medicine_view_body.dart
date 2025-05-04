import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/widgets/custom_app_bar.dart';
import 'package:graduation_project/features/add_medicine/domain/entities/add_new_medicine_entity.dart';
import 'package:graduation_project/features/add_medicine/presentation/services/medicine_form_service.dart';
import 'package:graduation_project/features/add_medicine/presentation/views/widgets/medicine_text_field.dart';
import 'package:graduation_project/features/home/presentation/views/widgets/custom_home_button.dart';

import '../../manager/add_medicine_cubit/add_medicine_cubit.dart';
import 'image_field.dart';

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
    final void Function(String?)? onSaved,
  }) {
    return MedicineTextField(
      hintText: hintText,
      prefixIcon: icon,
      isDateField: true,
      selectedDate: isPurchasedDate
          ? _formService.purchasedDate
          : _formService.expiryDate,
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
late String medicineName , tabletCount , details , purchasedDate , expiryDate;
 File? imageFile;
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              title: 'Add New Medicine',
            ),
            const SizedBox(height: 20),
            MedicineTextField(
              onSaved: (value) {
                medicineName = value!;
              },
              hintText: 'Medicine Name',
              prefixIcon: Icons.medication,
              controller: _medicineNameController,
            ),
            const SizedBox(height: 16),
            MedicineTextField(
              onSaved: (value) {
                tabletCount = value!;
              },
              hintText: 'Tablet Count',
              prefixIcon: Icons.numbers,
              keyboardType: TextInputType.number,
              controller: _tabletCountController,
            ),
            const SizedBox(height: 16),
            _buildDateField(
              onSaved: (value){
                purchasedDate = value!;
              },
              hintText: 'Purchased Date',
              icon: Icons.calendar_month_outlined,
              isPurchasedDate: true,
            ),
            const SizedBox(height: 16),
            _buildDateField(
              onSaved: (value){
                expiryDate = value!;
              },
              hintText: 'Expiry Date',
              icon: Icons.event_busy_outlined,
              isPurchasedDate: false,
            ),
            _buildExpiryError(),
            const SizedBox(height: 16),
            MedicineTextField(
              onSaved: (value) {
                details = value!;
              },
              hintText: 'Details',
              prefixIcon: Icons.description,
              maxLines: 3,
              controller: _detailsController,
            ),
            const SizedBox(height: 16),
            ImageField(
              onFileChanged: (image) {
                imageFile = image;
              },
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '** Please Take a clear image for the medicine and the Date of production and Expiration date Visible **',
                  textAlign: TextAlign.center,
                  style: TextStyles.textstyle14.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: CustomHomeButton(
                  text: 'Add Medicine',
                  onPressed: () {
                    if(imageFile != null){
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        AddNewMedicineEntity input = AddNewMedicineEntity(
                          medicineName: medicineName,
                          tabletCount: tabletCount,
                          details: details,
                          purchasedDate: purchasedDate,
                          expiryDate: expiryDate,
                          imageFile: imageFile!,
                        );
                        context.read<AddMedicineCubit>().addMedicine(input);
                        
                      }else{
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    }else{
                      buildErrorBar(context, 'Please upload a medicine image');
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
