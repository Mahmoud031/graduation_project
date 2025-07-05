import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_images.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({
    super.key,
    required this.title,
    this.onPressed,
  });
  final void Function()? onPressed;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          AppImages.logo,
          width: 40,
          height: 40,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.person_outline,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
