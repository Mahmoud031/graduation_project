import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/widgets/custom_app_bar.dart';
import 'package:graduation_project/features/donor_features/add_medicine/domain/entities/medicine_entity.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/services/medicine_form_service.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/views/widgets/add_medicine_widgets/date_field_widget.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/views/widgets/add_medicine_widgets/expiry_error_widget.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/views/widgets/medicine_text_field.dart';
import 'package:graduation_project/features/donor_features/find_ngo/presentation/views/widgets/custom_home_button.dart';
import '../../manager/add_medicine_cubit/add_medicine_cubit.dart';
import 'image_field.dart';

class AddNewMedicineViewBody extends StatefulWidget {
  final String ngoName;
  const AddNewMedicineViewBody({super.key, required this.ngoName});

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String medicineName = '',
      tabletCount = '',
      details = '',
      purchasedDate = '',
      expiryDate = '';
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
            DateFieldWidget(
              onSaved: (value) {
                purchasedDate = value!;
              },
              hintText: 'Purchased Date',
              icon: Icons.calendar_month_outlined,
              isPurchasedDate: true,
              selectedDate: _formService.purchasedDate,
              onDateTap: () async {
                await _formService.selectDate(context, true);
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
            DateFieldWidget(
              onSaved: (value) {
                expiryDate = value!;
              },
              hintText: 'Expiry Date',
              icon: Icons.event_busy_outlined,
              isPurchasedDate: false,
              selectedDate: _formService.expiryDate,
              onDateTap: () async {
                await _formService.selectDate(context, false);
                setState(() {});
              },
            ),
            ExpiryErrorWidget(errorMessage: _formService.expiryError),
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
                    if (imageFile != null) {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final currentUser = getUser();
                        MedicineEntity input = MedicineEntity(
                          medicineName: medicineName,
                          tabletCount: tabletCount,
                          details: details,
                          purchasedDate: _formService.purchasedDate != null
                              ? '${_formService.purchasedDate!.day}/${_formService.purchasedDate!.month}/${_formService.purchasedDate!.year}'
                              : '',
                          expiryDate: _formService.expiryDate != null
                              ? '${_formService.expiryDate!.day}/${_formService.expiryDate!.month}/${_formService.expiryDate!.year}'
                              : '',
                          imageFile: imageFile!,
                          ngoName: widget.ngoName,
                          userId: currentUser.uId,
                        );
                        print('Adding medicine for NGO: ${input.ngoName}');
                        context.read<AddMedicineCubit>().addMedicine(input);
                      } else {
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    } else {
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
