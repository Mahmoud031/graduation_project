import 'package:flutter/material.dart';

void buildErrorBar(BuildContext context, String message) {
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color(0xff081720),
        duration: const Duration(seconds: 2),
      ),
    );
  }

