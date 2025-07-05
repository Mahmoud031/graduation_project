import 'package:flutter/material.dart';

import 'terms_and_conditions_view_body.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});
  static const String routeName = 'terms_and_conditions';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const TermsAndConditionsViewBody(),
    );
  }
}
