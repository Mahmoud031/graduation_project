import 'package:flutter/material.dart';
import 'package:graduation_project/core/widgets/custom_button.dart';


class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key, required this.onPressed});
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Edit Profile',
      onPressed: onPressed,
      size: Size(
        MediaQuery.of(context).size.width * 0.8,
        50,
      ),
    );
  }
}
