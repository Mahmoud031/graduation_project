import 'package:flutter/material.dart';
import 'package:graduation_project/features/auth/presentation/views/change_password_view.dart';

class PasswordChangeSection extends StatelessWidget {
  const PasswordChangeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.lock_outline),
        title: const Text('Change Password'),
        subtitle: const Text('Update your account password'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.pushNamed(context, ChangePasswordView.routeName);
        },
      ),
    );
  }
}
