import 'package:flutter/material.dart';

class PrivacyNotice extends StatelessWidget {
  const PrivacyNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2E7D32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.privacy_tip,
                color: Color(0xFF2E7D32),
              ),
              SizedBox(width: 8),
              Text(
                'Privacy Notice',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Your medical information is handled with utmost confidentiality. We comply with all data protection regulations and never share your personal information without your explicit consent.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF1B5E20),
            ),
          ),
        ],
      ),
    );
  }
}
