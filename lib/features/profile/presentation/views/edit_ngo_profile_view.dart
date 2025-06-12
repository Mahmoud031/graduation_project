import 'package:flutter/material.dart';

import 'ngo_widgets/edit_ngo_profile_view_body.dart';

class EditNgoProfileView extends StatelessWidget {
  const EditNgoProfileView({super.key});
  static const String routeName = 'editNgoProfileView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              title: Text(
                'Edit NGO Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.blue.shade50,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.blue.shade700),
                onPressed: () => Navigator.pop(context),
              ),
            ),
      body: const EditNgoProfileViewBody(),
    );
  }
}