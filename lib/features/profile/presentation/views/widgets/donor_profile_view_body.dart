import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_app_bar.dart';

class DonorProfileViewBody extends StatelessWidget {
  const DonorProfileViewBody({super.key});

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
