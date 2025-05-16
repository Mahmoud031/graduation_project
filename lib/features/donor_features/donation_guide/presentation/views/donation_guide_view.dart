import 'package:flutter/material.dart';
import 'package:graduation_project/features/donor_features/donation_guide/presentation/views/widgets/donation_guide_view_body.dart';

class DonationGuideView extends StatelessWidget {
  const DonationGuideView({super.key});
  static const String routeName = 'donation_guide_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: DonationGuideViewBody(),
    );
  }
}