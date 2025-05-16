import 'package:flutter/material.dart';

class ExpiryErrorWidget extends StatelessWidget {
  final String? errorMessage;

  const ExpiryErrorWidget({
    super.key,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 8.0),
      child: Text(
        errorMessage!,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 14,
        ),
      ),
    );
  }
} 