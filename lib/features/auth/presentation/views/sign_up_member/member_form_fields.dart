import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/widgets/custom_text_field.dart';
import 'package:graduation_project/core/widgets/password_field.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_up_member/donor_type_drop_down.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/terms_and_conditions.dart';

class MemberFormFields extends StatelessWidget {
  final Function(String?) onNameSaved;
  final Function(String?) onEmailSaved;
  final Function(String?) onAgeSaved;
  final Function(String?) onPhoneSaved;
  final Function(String?) onNationalIdSaved;
  final Function(String?) onPasswordSaved;
  final Function(String?) onAddressSaved;
  final Function(String?) onTypeSaved;
  final Function(bool) onTermsChanged;
  final TextEditingController? passwordController; // Add password controller

  const MemberFormFields({
    super.key,
    required this.onNameSaved,
    required this.onEmailSaved,
    required this.onAgeSaved,
    required this.onPhoneSaved,
    required this.onNationalIdSaved,
    required this.onPasswordSaved,
    required this.onAddressSaved,
    required this.onTypeSaved,
    required this.onTermsChanged,
    this.passwordController, // Add password controller parameter
  });

  // Validation functions
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validateNationalId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter national ID';
    }
    if (value.length != 14) {
      return 'National ID must be 14 numbers';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'National ID must contain only numbers';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (passwordController != null && value != passwordController!.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Member Registration',
            style: TextStyles.textstyle25.copyWith(color: Colors.black)),
        Divider(
          color: Colors.black,
          indent: MediaQuery.of(context).size.width * 0.1,
          endIndent: MediaQuery.of(context).size.width * 0.1,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          onSaved: onNameSaved,
          hintText: 'Enter Full Name',
          labelText: 'Name',
          prefixIcon: Icons.person,
          textInputType: TextInputType.name,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          onSaved: onEmailSaved,
          hintText: 'Enter Email',
          labelText: 'Email',
          prefixIcon: Icons.email,
          textInputType: TextInputType.emailAddress,
          validator: _validateEmail,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          onSaved: onAgeSaved,
          hintText: 'Enter Age',
          labelText: 'Age',
          prefixIcon: Icons.calendar_today_rounded,
          textInputType: TextInputType.number,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          onSaved: onPhoneSaved,
          hintText: 'Enter phone number',
          labelText: 'Contact',
          prefixIcon: Icons.phone,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          onSaved: onNationalIdSaved,
          hintText: 'National id',
          labelText: 'National id',
          prefixIcon: Icons.badge,
          textInputType: TextInputType.number,
          validator: _validateNationalId,
        ),
        const SizedBox(height: 10),
        PasswordField(
          labelText: 'Password',
          hintText: 'Enter Password',
          onSaved: onPasswordSaved,
          validator: _validatePassword,
          controller: passwordController, // Pass the controller to password field
        ),
        const SizedBox(height: 10),
        PasswordField(
          labelText: 'Confirm Password',
          hintText: 'Confirm Password',
          validator: _validateConfirmPassword,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          onSaved: onAddressSaved,
          hintText: 'Enter Address',
          labelText: 'Address',
          prefixIcon: Icons.location_on_outlined,
        ),
        const SizedBox(height: 10),
        DonorTypeDropdown(
          onSaved: onTypeSaved,
        ),
        const SizedBox(height: 10),
        TermsAndConditions(
          onChanged: onTermsChanged,
        ),
      ],
    );
  }
} 