import 'package:flutter/material.dart';

import 'widgets/donations_view_body.dart';

class DonationsView extends StatelessWidget {
  const DonationsView({super.key});
  static const String routeName = 'donations_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: DonationsViewBody());
  }
}