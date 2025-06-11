import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:graduation_project/features/auth/presentation/cubits/change_password_cubit/change_password_cubit.dart';
import 'package:graduation_project/features/auth/presentation/views/widgets/change_password_view_body.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});
  static const String routeName = 'changePasswordView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Change Password'),
          backgroundColor: const Color(0xff081720),
          foregroundColor: Colors.white,
        ),
        backgroundColor: const Color(0xff081720),
        body: const ChangePasswordViewBody(),
      ),
    );
  }
} 