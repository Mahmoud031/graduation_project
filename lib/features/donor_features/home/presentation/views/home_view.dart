import 'package:flutter/material.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/core/widgets/custom_home_app_bar.dart';
import 'package:graduation_project/features/donor_features/home/presentation/views/widgets/home_view_body.dart';

import '../../../../profile/presentation/views/donor_profile_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String routeName = 'home_view';

  @override
  Widget build(BuildContext context) {
    final donor = getUser();
    return Scaffold(
      backgroundColor: Color(0xffC2E1E3),
      appBar: CustomHomeAppBar(
        title: 'Welcome, ${donor.name}',
        onPressed: () {
          Navigator.pushNamed(context, DonorProfileView.routeName);
        },
      ),
      body: const SafeArea(
        child: HomeViewBody(),
      ),
    );
  }
}
