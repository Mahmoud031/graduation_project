import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_app_bar.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: 'My Profile',
        ),
      ],
    );
  }
}
