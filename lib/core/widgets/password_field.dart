import 'package:flutter/material.dart';
import 'custom_text_field.dart';
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key, this.onSaved,
  });
  final void Function(String?)? onSaved;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      onSaved: (value) {
        
      },
      obscureText: obscureText,
      hintText: 'Enter Password',
      labelText: 'Password',
      prefixIcon: Icons.lock_outlined,
      suffixIcon: GestureDetector(
        onTap: () {
          obscureText = !obscureText;
          setState(() {});
        },
        child: obscureText
            ? const Icon(Icons.visibility_outlined)
            :
        const Icon(Icons.visibility_off_outlined),
      ),
    );
  }
}