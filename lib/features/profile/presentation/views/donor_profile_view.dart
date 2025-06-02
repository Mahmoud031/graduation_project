import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_side_bar.dart';

import 'widgets/donor_profile_view_body.dart';

class DonorProfileView extends StatelessWidget {
  const DonorProfileView({super.key});
  static const String routeName = 'donorProfileView';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomSideBar(),
        body: DonorProfileViewBody(),
      ),
    );
  }
}
