import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import 'package:graduation_project/features/auth/presentation/views/sign_in/social_login_widget.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({
    super.key,
    required this.onTapGoogle,
  });
  final VoidCallback onTapGoogle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SocialLoginWidget(
        image: AppImages.loginViewGoogle,
        onTap: onTapGoogle,
      ),
    );
  }
}
