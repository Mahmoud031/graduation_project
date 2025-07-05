import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_side_bar.dart';
import 'widgets/find_ngo_view_body.dart';

class FindNgoView extends StatelessWidget {
  const FindNgoView({super.key});
  static const String routeName = 'find_ngo_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC2E1E3),
      drawer: const CustomSideBar(),
      body: SafeArea(child: FindNgoViewBody()),
    );
  }
}
