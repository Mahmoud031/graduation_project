import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CheckBox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      value: value,
      onChanged: onChanged,
    );
  }
}
