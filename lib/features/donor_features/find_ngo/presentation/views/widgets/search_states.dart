import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';

class SearchStates extends StatelessWidget {
  final bool isSearching;
  final String message;
  final IconData icon;
  final Color iconColor;

  const SearchStates({
    super.key,
    required this.isSearching,
    required this.message,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: iconColor,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyles.textstyle18.copyWith(
              color: Colors.black54,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          if (isSearching) ...[
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
          ],
        ],
      ),
    );
  }
} 