import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_home_app_bar.dart';
import 'widgets/ngo_donations_view_body.dart';

class NgoDonationsView extends StatelessWidget {
  const NgoDonationsView({super.key});
  static const String routeName = 'ngo_donations_view';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomHomeAppBar(title: 'NGO Donations'),
        backgroundColor: Colors.white,
        body: const NgoDonationsViewBody(),
      ),
    );
  }
}
