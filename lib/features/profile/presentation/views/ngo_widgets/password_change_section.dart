import 'package:flutter/material.dart';
import 'package:graduation_project/features/auth/presentation/views/change_password/change_password_view.dart';

class PasswordChangeSection extends StatelessWidget {
  const PasswordChangeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: ListTile(
        leading: Icon(Icons.lock_outline, color: Colors.blue.shade700),
        title: Text(
          'Change Password',
          style: TextStyle(
            color: Colors.blue.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          'Update your account password',
          style: TextStyle(
            color: Colors.blueGrey,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blue.shade700),
        onTap: () {
          Navigator.pushNamed(context, ChangePasswordView.routeName);
        },
      ),
    );
  }
}
