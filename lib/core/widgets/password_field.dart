import 'package:flutter/material.dart';
import 'custom_text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.onSaved, required this.hintText, required this.labelText, this.validator,
  });
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String hintText;
  final String labelText;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      onSaved: widget.onSaved,
      validator: widget.validator,
      obscureText: obscureText,
      hintText:  widget.hintText,
      labelText:  widget.labelText,
      prefixIcon: Icons.lock_outlined,
      suffixIcon: GestureDetector(
        onTap: () {
          obscureText = !obscureText;
          setState(() {});
        },
        child: obscureText
            ? const Icon(Icons.visibility_off_outlined)
            : const Icon(Icons.visibility_outlined),
      ),
    );
  }
}
