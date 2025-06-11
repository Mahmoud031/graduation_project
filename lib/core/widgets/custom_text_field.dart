import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.size = 18,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.labelText,
    this.textInputType,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.enabled = true,
    this.controller,
  });

  final String hintText;
  final double size;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? labelText;
  final TextInputType? textInputType;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool enabled;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        enabled: enabled,
        onSaved: onSaved,
        validator: validator ?? (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        keyboardType: textInputType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
          hintStyle: TextStyle(
            color: Colors.black54,
            fontSize: size,
          ),
          hintText: hintText,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.grey)
              : null, // Only show the prefixIcon if it's not null
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.black54)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
