import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_side_bar.dart';

import 'widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String routeName = 'home_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC2E1E3),
      drawer: const CustomSideBar(),
      body: SafeArea(child: HomeViewBody()),
    );
  }
}
