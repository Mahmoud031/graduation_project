import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';

class ActiveItem extends StatelessWidget {
  const ActiveItem({super.key, required this.text, required this.icon});
  final String text;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2B7A78),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: ShapeDecoration(
              color: const Color(0xFF88CCC9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Center(
              child: Icon(
                icon.icon,
                color: const Color(0xFF2B7A78),
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyles.textstyle16.copyWith(
              color: Color(0xFFFDFDFD),
            ),
          ),
        ],
      ),
    );
  }
}
