import 'package:flutter/material.dart';
import 'package:graduation_project/features/donor_features/add_medicine/presentation/views/widgets/medicine_text_field.dart';

class DateFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPurchasedDate;
  final DateTime? selectedDate;
  final Function() onDateTap;
  final void Function(String?)? onSaved;

  const DateFieldWidget({
    super.key,
    required this.hintText,
    required this.icon,
    required this.isPurchasedDate,
    required this.selectedDate,
    required this.onDateTap,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return MedicineTextField(
      hintText: hintText,
      prefixIcon: icon,
      isDateField: true,
      selectedDate: selectedDate,
      onDateTap: onDateTap,
      controller: TextEditingController(),
      onSaved: onSaved,
    );
  }
} 