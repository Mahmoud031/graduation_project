import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_in/sign_in_view.dart';

class SignInLink extends StatelessWidget {
  const SignInLink({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, SigninView.routeName),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Already have an account?',
              style: TextStyles.textstyle14.copyWith(color: Colors.black)),
          const SizedBox(width: 4),
          Text('Sign in',
              style: TextStyles.textstyle14.copyWith(color: Color(0xFF4285F4))),
        ],
      ),
    );
  }
} 