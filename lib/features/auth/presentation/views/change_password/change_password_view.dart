import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:graduation_project/features/auth/presentation/cubits/change_password_cubit/change_password_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/change_password/change_password_view_body.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});
  static const String routeName = 'changePasswordView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Change Password',
            style: TextStyle(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blue.shade50,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.blue.shade700),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Colors.blue.shade50,
        body: const ChangePasswordViewBody(),
      ),
    );
  }
}
