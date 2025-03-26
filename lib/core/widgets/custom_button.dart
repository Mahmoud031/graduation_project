import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.size,
    required this.onPressed,
  });
  final String text;
  final Size size;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: size,
            backgroundColor: Color(0xA3091521),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          )),
    );
  }
}
