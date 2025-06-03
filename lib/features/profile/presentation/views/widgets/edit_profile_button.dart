import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_button.dart';
import '../edit_ngo_profile_view.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Edit Profile',
      onPressed: () {
        Navigator.pushNamed(context, EditNgoProfileView.routeName);
      },
      size: Size(
        MediaQuery.of(context).size.width * 0.8,
        50,
      ),
    );
  }
}
