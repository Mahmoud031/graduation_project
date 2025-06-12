import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_home_app_bar.dart';
import 'package:graduation_project/features/ngo_features/ngo_support_center/presentation/views/widgets/ngo_support_center_view_body.dart';

class NgoSupportCenterView extends StatelessWidget {
  const NgoSupportCenterView({super.key});
  static const String routeName = 'ngoSupportCenter';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeAppBar(title: 'Support Center'),
      body: const NgoSupportCenterViewBody(),
    );
  }
}
