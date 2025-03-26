import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xffCFD4D6),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Text("Or", style: TextStyles.textstyle14),
        ),
        Expanded(
          child: Divider(
            color: Color(0xffCFD4D6),
          ),
        ),
      ],
    );
  }
}
