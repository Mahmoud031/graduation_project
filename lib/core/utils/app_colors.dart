import 'package:flutter/material.dart';

abstract class AppColors {
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment(0.50, -0.50),
    end: Alignment(0.50, 1.00),
    colors: [Color(0xFFDEFEFF), Color(0xFF071A26)],
  );
}