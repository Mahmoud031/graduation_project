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
  });

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
        ),
        const SizedBox(height: 10),
        PasswordField(
          labelText: 'Password',
          hintText: 'Enter Password',
          onSaved: onPasswordSaved,
        ),
        const SizedBox(height: 10),
        PasswordField(
          labelText: 'Confirm Password',
          hintText: 'Confirm Password',
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