import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_up_view.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?", style: TextStyles.textstyle14),
        const SizedBox(
          width: 4,
        ),
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, SignUpView.routeName);
            },
            child: Text('Sign Up',
                textAlign: TextAlign.center,
                style: TextStyles.textstyle14.copyWith(color: Colors.blue))),
      ],
    );
  }
}
