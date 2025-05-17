import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_home_app_bar.dart';

import 'widgets/ngo_home_view_body.dart';

class NgoHomeView extends StatelessWidget {
  const NgoHomeView({super.key});
  static const routeName = 'ngoHomeView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: CustomHomeAppBar(
        title: 'Home View',
      ),
      body: const SafeArea(
        child: NgoHomeViewBody(),
      ),
    );
  }
}
