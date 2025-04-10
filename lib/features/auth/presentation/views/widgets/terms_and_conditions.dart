import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';

import 'check_box.dart';

class TermsAndConditions extends StatelessWidget {
   TermsAndConditions({super.key});
  late bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
            scale: 1.3,
            child: CheckBox(onChanged: (bool value) {  
               isChecked = value;
            },) 
            ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text.rich(TextSpan(children: [
            TextSpan(
                text: 'By creating an account, you agree to ',
                style: TextStyles.textstyle14),
            TextSpan(
                text: 'our terms and conditions',
                style: TextStyles.textstyle14.copyWith(color: Colors.blue)),
          ])),
        )
      ],
    );
  }
}
