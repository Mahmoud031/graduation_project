import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/widgets/custom_text_field.dart';
import 'package:graduation_project/core/widgets/password_field.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/terms_and_conditions.dart';

class NgoFormFields extends StatelessWidget {
  final Function(String?) onNameSaved;
  final Function(String?) onEmailSaved;
  final Function(String?) onPhoneSaved;
  final Function(String?) onNgoIdSaved;
  final Function(String?) onPasswordSaved;
  final Function(String?) onAddressSaved;
  final Function(bool) onTermsChanged;
  final TextEditingController? passwordController;

  const NgoFormFields({
    super.key,
    required this.onNameSaved,
    required this.onEmailSaved,
    required this.onPhoneSaved,
    required this.onNgoIdSaved,
    required this.onPasswordSaved,
    required this.onAddressSaved,
    required this.onTermsChanged,
    this.passwordController,
  });

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
        Text('Ngo Registration',
            style: TextStyles.textstyle25.copyWith(color: Colors.black)),
        Divider(
          color: Colors.black,
          indent: MediaQuery.of(context).size.width * 0.1,
          endIndent: MediaQuery.of(context).size.width * 0.1,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          onSaved: onNameSaved,
          hintText: 'Enter Ngo Name',
          labelText: 'Ngo Name',
          prefixIcon: Icons.person,
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
          onSaved: onPhoneSaved,
          hintText: 'Enter phone number',
          labelText: 'Contact',
          prefixIcon: Icons.phone,
          textInputType: TextInputType.phone,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          onSaved: onNgoIdSaved,
          hintText: 'Ngo id',
          labelText: 'Enter Ngo id',
          prefixIcon: Icons.badge,
        ),
        const SizedBox(height: 10),
        PasswordField(
          onSaved: onPasswordSaved,
          labelText: 'Password',
          hintText: 'Enter Password',
          validator: _validatePassword,
          controller:
              passwordController, // Pass the controller to password field
        ),
        const SizedBox(height: 10),
        PasswordField(
          labelText: 'confirm Password',
          hintText: 'confirm Password',
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
        TermsAndConditions(
          onChanged: onTermsChanged,
        ),
      ],
    );
  }
}
