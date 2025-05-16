import 'package:flutter/material.dart';

import 'widgets/reports_view_body.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});
  static const String routeName = 'reports_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ReportsViewBody(),
    );
  }
}