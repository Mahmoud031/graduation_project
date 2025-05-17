import 'package:flutter/material.dart';

import 'widgets/donation_management_view_body.dart';

class DonationManagementView extends StatelessWidget {
  const DonationManagementView({super.key});
  static const String routeName = 'donation_management_view';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: const DonationManagementViewBody(),
      ),
    );
  }
}
