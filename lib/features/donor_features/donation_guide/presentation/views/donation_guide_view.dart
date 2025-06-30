import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/donor_features/donation_guide/presentation/views/widgets/donation_guide_view_body.dart';

class DonationGuideView extends StatelessWidget {
  const DonationGuideView({super.key});
  static const String routeName = 'donation_guide_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Donation Guide',
          style: TextStyles.textstyle30.copyWith(
            color: Colors.green,
          ),
        ),
        centerTitle: true,
      ),
      body: DonationGuideViewBody(),
    );
  }
}
