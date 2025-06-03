import 'package:flutter/material.dart';

import 'widgets/edit_donor_profile_view_body.dart';

class EditDonorProfileView extends StatelessWidget {
  const EditDonorProfileView({super.key});
  static const String routeName = 'editDonorProfileView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: const EditDonorProfileViewBody(),
    );
  }
}