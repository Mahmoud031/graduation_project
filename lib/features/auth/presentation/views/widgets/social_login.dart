import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/social_login_widget.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key, required this.onTapGoogle, required this.onTapFacebook});
  final VoidCallback onTapGoogle;
  final VoidCallback onTapFacebook;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialLoginWidget(
          image: AppImages.loginViewGoogle,
          onTap: onTapGoogle,
          
        ),
        const SizedBox(
          width: 20,
        ),
        SocialLoginWidget(
          image: AppImages.loginViewFacebook,
          onTap: onTapFacebook,
        ),
      ],
    );
  }
}
