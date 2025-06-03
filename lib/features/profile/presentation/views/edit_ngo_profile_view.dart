import 'package:flutter/material.dart';

import 'ngo_widgets/edit_ngo_profile_view_body.dart';

class EditNgoProfileView extends StatelessWidget {
  const EditNgoProfileView({super.key});
  static const String routeName = 'editNgoProfileView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: const EditNgoProfileViewBody(),
    );
  }
}