import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final String title;
  final DateTime? selectedDate;
  final VoidCallback onTap;
  final String? errorText;

  const DatePickerField({
    super.key,
    required this.title,
    required this.selectedDate,
    required this.onTap,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(title),
          subtitle: Text(
            selectedDate == null
                ? 'Select date'
                : DateFormat('yyyy-MM-dd').format(selectedDate!),
          ),
          trailing: const Icon(Icons.calendar_today),
          onTap: onTap,
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 4.0),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
} 