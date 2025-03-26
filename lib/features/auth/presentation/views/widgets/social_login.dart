import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/social_login_widget.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialLoginWidget(
          image: AppImages.loginViewGoogle,
          onTap: () {},
        ),
        const SizedBox(
          width: 20,
        ),
        SocialLoginWidget(
          image: AppImages.loginViewFacebook,
          onTap: () {},
        ),
      ],
    );
  }
}
