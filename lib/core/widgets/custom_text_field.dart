import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.size = 18,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.labelText, required this.textInputType,
  });
  final String hintText;
  final double size;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final String? labelText;
  final TextInputType textInputType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 49,
      width: 363,
      child: TextFormField(
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
          suffixIcon:
              suffixIcon != null ? Icon(suffixIcon, color: Colors.grey) : null,
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
