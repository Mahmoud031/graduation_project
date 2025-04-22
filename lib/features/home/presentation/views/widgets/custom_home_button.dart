import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';

class CustomHomeButton extends StatelessWidget {
  const CustomHomeButton({
    super.key,
    this.onPressed,
    required this.text,
  });
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF007B83),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: TextStyles.textstyle14,
      ),
    );
  }
}
