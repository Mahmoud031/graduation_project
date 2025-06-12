import 'package:flutter/material.dart';

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
