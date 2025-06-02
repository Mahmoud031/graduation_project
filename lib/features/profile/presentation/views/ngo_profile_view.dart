import 'package:flutter/material.dart';

import 'widgets/ngo_profile_view_body.dart';

class NgoProfileView extends StatelessWidget {
  const NgoProfileView({super.key});
  static const String routeName = 'ngoProfileView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NgoProfileViewBody(),
    );
  }
}
