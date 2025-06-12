import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_home_app_bar.dart';
import 'widgets/donation_management_view_body.dart';

class DonationManagementView extends StatelessWidget {
  const DonationManagementView({super.key});
  static const String routeName = 'donation_management_view';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomHomeAppBar(title: 'Donation Management'),
        backgroundColor: Colors.white,
        body: const DonationManagementViewBody(),
      ),
    );
  }
}
