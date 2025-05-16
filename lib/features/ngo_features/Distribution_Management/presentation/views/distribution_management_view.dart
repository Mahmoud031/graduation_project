import 'package:flutter/material.dart';

import 'widgets/distribution_management_view_body.dart';

class DistributionManagementView extends StatelessWidget {
  const DistributionManagementView({super.key});
  static const String routeName = 'distribution_management_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: const DistributionManagementViewBody(),
    );
  }
}