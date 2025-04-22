import 'package:flutter/material.dart';

class MedicineTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool isDateField;
  final DateTime? selectedDate;
  final VoidCallback? onDateTap;

  const MedicineTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
    this.maxLines = 1,
    this.isDateField = false,
    this.selectedDate,
    this.onDateTap, required TextEditingController controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: TextFormField(
          maxLines: maxLines,
          keyboardType: keyboardType,
          readOnly: isDateField,
          onTap: isDateField ? onDateTap : null,
          controller: isDateField
              ? TextEditingController(
                  text: selectedDate != null
                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                      : '',
                )
              : null,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }
}
