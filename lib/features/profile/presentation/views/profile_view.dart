import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_side_bar.dart';

import 'widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const String routeName = 'profileView';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomSideBar(),
        body: ProfileViewBody(),
      ),
    );
  }
}
