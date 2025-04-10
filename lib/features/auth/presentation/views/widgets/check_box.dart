import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  const CheckBox({super.key, required this.onChanged});
  final ValueChanged<bool> onChanged;
  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      value: isChecked,
      onChanged: (value) {
        isChecked = value!;
        widget.onChanged(value);
        setState(() {
           // Toggle checkbox state
        });
      },
    );
  }
}
