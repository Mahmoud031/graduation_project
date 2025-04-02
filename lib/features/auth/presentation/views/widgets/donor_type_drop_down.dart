import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';

class DonorTypeDropdown extends StatefulWidget {
  const DonorTypeDropdown({super.key});

  @override
  _DonorTypeDropdownState createState() => _DonorTypeDropdownState();
}

class _DonorTypeDropdownState extends State<DonorTypeDropdown> {
  final List<String> donorTypes = [
    "Individual",
    "Care Center",
    "Patient",
    "Pharmacies",
    "Wholesalers",
    "Manufacturers"
  ];

  String? selectedDonorType; // Holds selected value

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Donor Type",
        labelStyle: TextStyles.textstyle18.copyWith(color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        filled: true,
        fillColor: Colors.white,
      ),
      value: selectedDonorType,
      items: donorTypes.map((type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(
            type,
            style: TextStyles.textstyle18.copyWith(color: Colors.black),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedDonorType = value;
        });
      },
    );
  }
}
