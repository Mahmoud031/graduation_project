import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_home_app_bar.dart';

import 'widgets/reports_view_body.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});
  static const String routeName = 'reports_view';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomHomeAppBar(title: 'Reports'),
        backgroundColor: Colors.white,
        body: const ReportsViewBody(),
      ),
    );
  }
}
