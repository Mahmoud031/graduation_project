import 'package:flutter/material.dart';

import 'widgets/support_enter_view_body.dart';

class SupportCenterView extends StatelessWidget {
  const SupportCenterView({super.key});
  static const String routeName = 'support_center_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SupportCenterViewBody()
    );
  }
}