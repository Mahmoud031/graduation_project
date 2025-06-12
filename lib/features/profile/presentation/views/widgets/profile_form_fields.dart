import 'package:flutter/material.dart';
import 'package:graduation_project/features/profile/presentation/views/ngo_widgets/custom_profile_text_field.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_up_member/donor_type_drop_down.dart';

class ProfileFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController nationalIdController;
  final TextEditingController ageController;
  final String? selectedType;
  final Function(String?) onTypeChanged;

  const ProfileFormFields({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.addressController,
    required this.nationalIdController,
    required this.ageController,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomProfileTextField(
          controller: nameController,
          label: 'Full Name',
          icon: Icons.person,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomProfileTextField(
          controller: nationalIdController,
          label: 'National ID',
          icon: Icons.perm_identity,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your national ID';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomProfileTextField(
          controller: ageController,
          label: 'Age',
          icon: Icons.calendar_today,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your age';
            }
            if (int.tryParse(value) == null) {
              return 'Please enter a valid age';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomProfileTextField(
          controller: phoneController,
          label: 'Phone',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomProfileTextField(
          controller: addressController,
          label: 'Address',
          icon: Icons.location_on,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your address';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        DonorTypeDropdown(
          initialValue: selectedType,
          onSaved: onTypeChanged,
        ),
      ],
    );
  }
} 