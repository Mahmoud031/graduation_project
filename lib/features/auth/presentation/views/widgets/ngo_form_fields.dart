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

  const NgoFormFields({
    super.key,
    required this.onNameSaved,
    required this.onEmailSaved,
    required this.onPhoneSaved,
    required this.onNgoIdSaved,
    required this.onPasswordSaved,
    required this.onAddressSaved,
    required this.onTermsChanged,
  });

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
        ),
        const SizedBox(height: 10),
        PasswordField(
          labelText: 'confirm Password',
          hintText: 'confirm Password',
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
